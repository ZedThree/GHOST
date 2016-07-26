/************************************************************************
 * Application: xgenie
 * File       : xgenie.c
 * Author     : I.G.D.Strachan - Harwell Instruments
 * Date       : 4/3/92
 * Version    : 1.3
 * Description: Xgenie is an X graphics handler for GHOST-80 applications
 *              it is forked by a GHOST-80 program when the user calls
 *              PAPER, and communicates with the GHOST-80 program, using
 *              Inter-Process-Communication (IPC). The normal way
 *              of doing this would be via two UNIX style pipes, one for
 *              graphics output requests, and one for graphics input 
 *              requests. This takes place by means of a simple
 *              protocol. Utilising the UNIX IPC means that the GHOST
 *              application does not need to access the Xlib library
 *              code. This is advantageous because Xlib causes a large
 *              amount of code to be dragged in. However, multiple
 *              GHOST applications running on the same machine only
 *              use one copy of the text segment of the xgenie program,
 *              as UNIX shares text segments.
 *
 *              This program uses the X toolkit, and is centred around
 *              an in-house designed "plot class widget".
 *
 *              Expose and resize events are handled by a "Replay buffer"
 *              which stores all the graphics commands in a dynamically
 *              allocated buffer.
 *
 *              A "fast redraw" option is provided whereby the graphics
 *              commands are also stored in a pixmap. On expose events
 *              without resize, this pixmap is copied to the screen; the
 *              replay buffer only being invoked when a resize has taken
 *              place, when the old pixmap is destroyed, a new one 
 *              created, and the replay buffer made to redraw.
 *
 *
 *
 * Status     : Released
 * QA check   : 
 * QA date    :
 ***********************************************************************/

/****************  INCLUDES             ********************************/
#include <stdio.h>
#include <X11/Intrinsic.h>
#include <X11/StringDefs.h>
#include <X11/Shell.h>
#ifdef _WIN32
#include <X11/xlibxtra.h>
#include <fcntl.h>
#include <io.h>
#endif
#include "ghost.xbm"
#include "Plot.h"
#include "Opcodes.h"

/****************  COMPILER DIRECTIVES  ********************************/
#define UndefinedOrigin  -10000
/****************  TYPE DEFINITIONS     ********************************/
typedef struct _APP_DATA
{
  Boolean  CMap;
  int  Width;
  int  Height;
  int  Xor;
  int  Yor;
  char *Geometry;
  char *Landscape;
  char *Bell;
} APP_DATA, *myAppData;
/****************  MACROS               ********************************/

/****************  GLOBAL VARIABLES     ********************************/
Widget TopLevel,Plot;
int DefaultWidth;
int DefaultHeight;
int DefaultXor=  UndefinedOrigin;
int DefaultYor=  UndefinedOrigin;
int DoBell=1;
/****************  STATIC VARIABLES     ********************************/
static char xgenie_cSID[] = "4/3/92 @(#)xgenie.c	1.3";
static int Quit=0;

static XrmOptionDescRec options[] = {
  {  "-kr"  ,    "*Plot*KeepRatio"   ,    XrmoptionNoArg,         "True"  },
  {  "+kr"  ,    "*Plot*KeepRatio"   ,    XrmoptionNoArg,         "False" },
  {  "-fr"  ,    "*Plot*FastRedraw"  ,    XrmoptionNoArg,         "True"  },
  {  "+fr"  ,    "*Plot*FastRedraw"  ,    XrmoptionNoArg,         "False" },
  {  "-ic"  ,    "*Plot*InputCursor" ,    XrmoptionSepArg,        NULL    },
  {  "-nc"  ,    "*Plot*NormalCursor",    XrmoptionSepArg,        NULL    },
  {  "-gtit",    "*iconName"         ,    XrmoptionSepArg,        NULL    },
  {  "-gminw" ,  "*minWidth"         ,    XrmoptionSepArg,        NULL    },
  {  "-gminh" ,  "*minHeight"        ,    XrmoptionSepArg,        NULL    },
  {  "-gmaxw" ,  "*maxWidth"         ,    XrmoptionSepArg,        NULL    },
  {  "-gmaxh" ,  "*maxHeight"        ,    XrmoptionSepArg,        NULL    },
  {  "-pd"    ,  "*Plot*PrettyDestroy",   XrmoptionSepArg,        NULL    },
  {  "-mc"    ,  "*Plot*MaxChunks"     ,   XrmoptionSepArg,       NULL    },
  {  "-cf"    ,  "*Plot*CursorForeground" , XrmoptionSepArg,      NULL    },
  {  "-cb"    ,  "*Plot*CursorBackground" , XrmoptionSepArg,      NULL    },
  {  "-gwid",    "*gWidth"           ,    XrmoptionSepArg,        NULL    },
  {  "-ght" ,    "*gHeight"          ,    XrmoptionSepArg,        NULL    },
  {  "-gxor",    "*gXor"             ,    XrmoptionSepArg,        NULL    },
  {  "-gyor",    "*gYor"             ,    XrmoptionSepArg,        NULL    },
  {  "-glan",    "*gLan"             ,    XrmoptionNoArg,         "True"  },
  {  "-gpor",    "*gLan"             ,    XrmoptionNoArg,         "False" }
  };

static XtResource resources[] =
{
  {"installCMap" ,"InstallCMap" ,XtRBoolean,sizeof(Boolean),XtOffset(myAppData,CMap ),
     XtRString,"False"},
  {"gWidth" ,"GWidth" ,XtRInt,sizeof(int),XtOffset(myAppData,Width ),
     XtRInt,(caddr_t) (&DefaultWidth)},
  {"gHeight","GHeight",XtRInt,sizeof(int),XtOffset(myAppData,Height),
     XtRInt,(caddr_t) (&DefaultHeight)},
  {"gXor"   ,"GXor"   ,XtRInt,sizeof(int),XtOffset(myAppData,Xor   ),
     XtRInt,(caddr_t) (&DefaultXor)},
  {"gYor"   ,"GYor"   ,XtRInt,sizeof(int),XtOffset(myAppData,Yor   ),
     XtRInt,(caddr_t) (&DefaultYor)},
  {"gLan"   ,"GLan"   ,XtRString,sizeof(char *),XtOffset(myAppData,Landscape),
     XtRString, "True"},
  {"gBell"  ,"GBell"  ,XtRString,sizeof(char *),XtOffset(myAppData,Bell),
     XtRString,"True" }
};



/****************  FUNCTION PROTOTYPES  ********************************/
void CommandHandler(caddr_t client_data,int* source,XtInputId* id);
/****************  FUNCTIONS            ********************************/
int main(int argc, char **argv)
{
  APP_DATA data;
  Colormap colourmap;
  Display *myDisplay;
  int myScreen;
  XtAppContext myContext;
  static char Geom[256];


  int i;
  static Arg args[10] = { {XtNiconPixmap , 0 },
			   {XtNinput, (XtArgVal) "True" }
                        };
   Pixmap myPixmap;
   static Arg TopLevelArgs[1];
   int ReturnArray[4];


  /*
   * 
   *
   * 1. Initialization of the toolkit
   */
#ifdef _WIN32
  _setmode(_fileno(stdin),_O_BINARY);
  _setmode(_fileno(stdout),_O_BINARY);
#endif
  XtToolkitInitialize();
  myContext   = XtCreateApplicationContext();
  myDisplay   = XtOpenDisplay(myContext,"",NULL,"Plot",options,
			      XtNumber(options),&argc,argv);
  DefaultWidth = DisplayWidth(myDisplay,DefaultScreen(myDisplay))/2;
  DefaultHeight= ( (float)DefaultWidth/1.4);

  myScreen    = DefaultScreen(myDisplay);

   myPixmap    = XCreateBitmapFromData(myDisplay,DefaultRootWindow(myDisplay),
				       icon_bitmap_bits,
				       icon_bitmap_width,
				       icon_bitmap_height);

   XtSetArg(args[0],XtNiconPixmap,(XtArgVal)myPixmap);
   switch(DisplayPlanes(myDisplay,myScreen))
     {
     case 2:
     case 3:
     case 4:
     case 5:
     case 6:
     case 7:
       {
	 XVisualInfo vTemplate,*visualList;
	 int visualsMatched;

	 vTemplate.screen = DefaultScreen(myDisplay);
         vTemplate.depth  = DisplayPlanes(myDisplay,myScreen);
	 vTemplate.class  = PseudoColor;
	 visualList       = XGetVisualInfo(myDisplay,
					   VisualScreenMask | 
					   VisualDepthMask  | 
					   VisualClassMask,
					   &vTemplate,&visualsMatched);
	 if(visualsMatched == 0)
	   {
#ifdef _WIN32
	     printf(
#else
		 fprintf(stderr,
#endif
		    "WARNING: standard colour handling not supported on this terminal\n");
#ifdef _WIN32
	     printf(
#else
	     fprintf(stderr,
#endif
		 "Your application may not handle colours correctly\n");
		 colourmap = DefaultColormap(myDisplay,DefaultScreen(myDisplay));
	     
	   }
	 else
	   {
	     colourmap = XCreateColormap(myDisplay,
					 RootWindow(myDisplay,DefaultScreen(myDisplay)),
					 visualList[0].visual,
					 AllocNone);
	   }
	 XtSetArg(args[1],XtNcolormap,(XtArgVal)colourmap);
         XtSetArg(args[2],XtNinput,(XtArgVal) True);
	 TopLevel    = XtAppCreateShell(NULL,"Plot",applicationShellWidgetClass,
					myDisplay,args,3);
	 XtSetArg(args[0],XtNcolormap,(XtArgVal)colourmap);
	 Plot = XtCreateManagedWidget("thePlot",plotWidgetClass,TopLevel,args,1);
	 break;
       }
     default:
         XtSetArg(args[2],XtNinput,(XtArgVal) True);

       TopLevel = XtAppCreateShell(NULL,"Plot",applicationShellWidgetClass,
				   myDisplay,args,3);
       Plot = XtCreateManagedWidget("thePlot",plotWidgetClass,TopLevel,args,3);

       colourmap = DefaultColormap(myDisplay,DefaultScreen(myDisplay));
     }


  XtGetApplicationResources( TopLevel , &data , resources, 
				XtNumber(resources),NULL,0);
  if(strcmp(data.Landscape,"False")==0)
    { /* Swap width & height to get portrait mode */
      int temp;
      temp = data.Width;
      data.Width = data.Height;
      data.Height = temp;
    }
  if(strcmp(data.Bell,"True"))
    DoBell=0;

  if(data.Xor == UndefinedOrigin && data.Yor == UndefinedOrigin )
     {
       sprintf(Geom,"%dx%d",data.Width,data.Height);
     }
   else
     {
       if(data.Xor == UndefinedOrigin)
         data.Xor = 0;
       if(data.Yor == UndefinedOrigin)
         data.Yor = 0;
       sprintf(Geom,"%dx%d%+-d%+-d",data.Width,data.Height,data.Xor,data.Yor);
     }

   XtSetArg(args[0],XtNgeometry,Geom);
   XtSetValues(TopLevel,args,1);

   if (data.CMap) 
     XInstallColormap(myDisplay,colourmap); 

   XtRealizeWidget(TopLevel);
   if (data.CMap) 
      XSetWindowColormap(myDisplay,XtWindow(TopLevel),colourmap);
  /* 3. Wait for first expose event on plot widget */
   while(Plot_IsMapped(Plot)==0)
     XtAppProcessEvent(myContext,XtIMAll);

  /* 4. Send necessary results back to parent */
   ReturnArray[0] = 0;
   ReturnArray[1] = 16383;
   ReturnArray[2] = 16383;
   ReturnArray[3] = DisplayPlanes(myDisplay,myScreen);
   fwrite(ReturnArray,4,sizeof(int),stdout);
   fflush(stdout);

  /* 5. Set up pipe handler */
#ifdef _WIN32
   XtAppAddInput(myContext,fileno(stdin),(XtPointer) XtInputReadFileHandle,CommandHandler,NULL);
#else
   XtAppAddInput(myContext,fileno(stdin),(XtPointer) XtInputReadMask,CommandHandler,NULL);
#endif
  /* 6. Main loop    */
   while(Quit==0)
     XtAppProcessEvent(myContext,XtIMAll);

  /* 7. Tidy up      */
   XtDestroyWidget(TopLevel);
   fwrite(&Quit,1,sizeof(int),stdout);
   fflush(stdout);
 }

/************************************************************************
 * Function Name   :  CommandHandler
 * Description     :  Handle commands from input stream
 ***********************************************************************/
#ifdef _WIN32
#define efread(A,B,C,D) \
  if(fread((A),(B),(C),(D)) != (C))\
     {\
	printf("broken pipe: Graphics program must have terminated abnormally\n");\
	Quit=1;\
	return;\
     }
#else
#define efread(A,B,C,D) \
  if(fread((A),(B),(C),(D)) != (C))\
     {\
	fprintf(stderr,"broken pipe: Graphics program must have terminated abnormally\n");\
	Quit=1;\
	return;\
     }
#endif
 
void CommandHandler(caddr_t client_data,int* source,XtInputId* id)
{
     int Loop,nread;
     int Command;
     int XBuffer[1024];
     int YBuffer[1024];

     Loop = True;

     while(Loop)
       {

	 efread(&Command,sizeof(int),1,stdin);
	 switch(Command)
	   {
	   case OP_POLYLINE:
	   case OP_POLYMARK:
	   case OP_FILLPOLY:
	     {
	       int Length;
	       efread(&Length,sizeof(int),1,stdin);
	       efread(XBuffer,sizeof(int),Length,stdin);
	       efread(YBuffer,sizeof(int),Length,stdin);
	       switch(Command)
		 {
		 case OP_POLYLINE:
		   Plot_PolyLine(Plot,XBuffer,YBuffer,Length);
		   break;
		 case OP_POLYMARK:
		   Plot_PolyMark(Plot,XBuffer,YBuffer,Length);
		   break;
		 case OP_FILLPOLY:
		   Plot_FillPoly(Plot,XBuffer,YBuffer,Length);
		   break;
		 }
	     break;
	     }
	   case OP_TEXT:
	     {
	       char TextBuffer[1024];
               char *ptr;
	       int X,Y;
	       efread(&X,sizeof(int),1,stdin);
	       efread(&Y,sizeof(int),1,stdin);
	       fgets(TextBuffer,1024,stdin);
	       ptr = TextBuffer;
	       while(*ptr != '\n')
		 ptr++;
	       *ptr='\0';
	       Plot_Text(Plot,X,Y,TextBuffer);
	       break;
	     }
	   case OP_COLTB:
	     {
	       int ColourNumber,Red,Green,Blue;
	       efread(&ColourNumber,sizeof(int),1,stdin);
	       efread(&Red         ,sizeof(int),1,stdin);
	       efread(&Green       ,sizeof(int),1,stdin);
	       efread(&Blue        ,sizeof(int),1,stdin);
	       Plot_DefineColour(Plot,ColourNumber,Red,Green,Blue);
	       break;
	     }
	   case OP_SETFC:
	     {
	       int ColourNumber;
	       efread(&ColourNumber,sizeof(int),1,stdin);
	       Plot_SetForeground(Plot,ColourNumber);
	       break;
	     }
	   case OP_GETIN:
	     {
	       int Results[5];
	       char Key;


	       if(DoBell)XBell(XtDisplay(Plot),100);
	       Plot_GetInput(Plot,
			     &(Results[0]),
			     &Key,
			     &(Results[1]),
			     &(Results[3]),
			     &(Results[4]));
               Results[2] = Key;
	       fwrite(Results,sizeof(int),5,stdout);
	       fflush(stdout);
	       Loop = False;
	       break;
	     }
	   case OP_FLUSH:
	     {
	       int Reply = 0;
	       Plot_Flush(Plot);
               Loop = False;
	       fwrite(&Reply,1,sizeof(int),stdout);
	       fflush(stdout);
	       break;
	     }
	   case OP_ERASE:
	     {
	       Plot_Erase(Plot);
	       break;
	     }
	   case OP_DEFIMAGE:
	     {
	       int id,x1,y1,x2,y2,w,h,startColour,endColour;
	       char *data,*dptr;
	       int BytesLeft;
	       int Reply=0;
	       efread(&id,sizeof(int),1,stdin);
	       efread(&x1,sizeof(int),1,stdin);
	       efread(&y1,sizeof(int),1,stdin);
	       efread(&x2,sizeof(int),1,stdin);
	       efread(&y2,sizeof(int),1,stdin);
	       efread(&w,sizeof(int),1,stdin);
	       efread(&h,sizeof(int),1,stdin);
	       efread(&startColour,sizeof(int),1,stdin);
	       efread(&endColour,sizeof(int),1,stdin);
	       data = XtMalloc(w*h);
	       dptr=data;
	       BytesLeft = w*h;
	       while(BytesLeft)
		 {
		   int BytesToRead;
		   if(BytesLeft > 4096)
		     BytesToRead = 4096;
		   else
		     BytesToRead = BytesLeft;
		   efread(dptr,sizeof(char),BytesToRead,stdin);
		   fwrite(&Reply,sizeof(int),1,stdout);
		   fflush(stdout);
		   BytesLeft -= BytesToRead;
		   dptr += BytesToRead;
		 }
	       Plot_DefineImage(Plot,id,x1,y1,x2,y2,w,h,startColour,endColour,data);
	       XtFree(data);
	       break;
	     }
	   case OP_PUTIMAGE:
	     {
	       int id;
	       efread(&id,sizeof(int),1,stdin);
	       Plot_PutImage(Plot,id);
	       break;
	     }
	   case OP_DUMPBUFFER:
	     {
	       char TextBuffer[1024];
               char *ptr;
	       fgets(TextBuffer,1024,stdin);
	       ptr = TextBuffer;
	       while(*ptr != '\n')
		 ptr++;
	       *ptr='\0';
	       Plot_DumpBuffer(Plot,TextBuffer);
	       break;
	     }
	       
	   case OP_QUIT:
	   default:
	     Quit = 1;
	     Loop = False;
	     break;
	   }
       }
}  
       
       
