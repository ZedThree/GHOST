
/************************************************************************
 * Application: Plot class widget.
 * File       : Plot.c
 * Author     : I.G.D.Strachan
 * Date       : 4/2/92
 * Version    : 1.1.1.2
 * Description: Widget implementation file for the Plot class widget.
 *              This is a general purpose plotting widget providing
 *              polyline, colours , fill and text primitives.
 *              Also supports graphical input (GIN).
 *
 *              It redraws at new scaling on resize, by use of 
 *              a replay buffer.
 *
 *              On expose, it provides a fast redraw facility
 *              by copying a pixmap to the screen. If not enough
 *              memory is available, a resource can be specified
 *              so that the pixmap is not created. Graphics requests
 *              are then written directly to the screen, and expose
 *              events are processed using the replay buffer.
 *
 * Other files: PlotGraphics.c  -- All the graphics primitives.
 *              PlotReplay.c    -- Replay buffer handling.
 *
 * Status     : Being modified
 * QA check   : 
 * QA date    :
 ***********************************************************************/

/****************  INCLUDES             ********************************/
#include <X11/IntrinsicP.h>
#include <X11/StringDefs.h>
#include <stdio.h>
#include "PlotP.h"
/****************  COMPILER DIRECTIVES  ********************************/
/****************  TYPE DEFINITIONS     ********************************/
/****************  MACROS               ********************************/
#define IM  714025
#define IA  1366
#define IC  150889
#define randnum(a)   (a= (a*IA + IC) % IM)
/****************  GLOBAL VARIABLES     ********************************/

/****************  STATIC VARIABLES     ********************************/
static char Plot_cSID[] = "@(#)Plot.c	1.1.1.2 4/2/92";
static int DefaultMaxChunks = 2048;
static int DefaultChunkSize = 2048;
static int DefaultWidth     = 512;
static int DefaultHeight    = 512;
static int DefaultDestroy   = 0;
static int DefaultCursorForeground = 1;
static int DefaultCursorBackground = 5;
static XtResource resources[] = {
#define offset(field) XtOffset(PlotWidget, plot.field)
    /* {name, class, type, size, offset, default_type, default_addr}, */

/**** Colours ******/
    { XtNforeground        , XtCColor    , XtRPixel    , sizeof(Pixel),
	offset(foreground),XtRString , XtDefaultForeground },
    { XtNbackground        , XtCColor    , XtRPixel    , sizeof(Pixel),
	offset(background),XtRString , XtDefaultBackground },

/***** Cursors *****/
    { XtNinputCursor      , XtCCursor , XtRCursor , sizeof(Cursor),
	offset(InputCursor), XtRString , "crosshair"},
    { XtNnormalCursor     , XtCCursor,  XtRCursor , sizeof(Cursor),
	offset(NormalCursor), XtRString , "diamond_cross"},
    { XtNcursorForeground , XtCValue , XtRInt , sizeof(int),
	offset(CursorForeground), XtRInt , (caddr_t) &DefaultCursorForeground},
    { XtNcursorBackground , XtCValue , XtRInt , sizeof(int),
	offset(CursorBackground), XtRInt , (caddr_t) &DefaultCursorBackground},

/***** Booleans *****/
    { XtNfastRedraw       , XtCBoolean , XtRBool , sizeof(Bool),
	offset(FastRedraw), XtRString , "False" },
    { XtNkeepRatio        , XtCBoolean , XtRBool , sizeof(Bool),
	offset(KeepRatio) , XtRString,  "True" },

/***** The Font *****/
    { XtNfont             , XtCFont,     XtRFontStruct, sizeof(XFontStruct *) ,
	offset(font)      , XtRString,  "XtDefaultFont" },
/***** Misc ********/
    { XtNprettyDestroy    , XtCValue , XtRInt , sizeof(int),
	offset(PrettyDestroy), XtRInt , (caddr_t) &DefaultDestroy },
    { XtNmaxChunks        , XtCValue , XtRInt , sizeof(int),
	offset(MaxChunks) , XtRInt , (caddr_t) &DefaultMaxChunks },
         
#undef offset
};
/****************  COMPILER DIRECTIVES  ********************************/
/****************  TYPE DEFINITIONS     ********************************/
/****************  MACROS               ********************************/
/****************  GLOBAL VARIABLES     ********************************/
/****************  STATIC VARIABLES     ********************************/
/****************  FUNCTION DECLARATIONS********************************/

/* Actions */
static void         InputAction();
static void         Redraw();
static void         Resize();
static void         Realize();
static void         ErasePixmap();
static void         FadeOut();
/* Others */
static XVisualInfo *InitColours();
static void         InitScaling();
static void         InitGC();


static XtActionsRec actions[] =
{
  /* { name, procedure }  */
  { "input" , InputAction },
};
static char translations[] =
{
"<BtnDown>: input()\n\
<KeyPress>: input()\n"
};
/****************  FUNCTIONS            ********************************/

/************************************************************************
 * Function Name   :  InputAction
 * Description     :  Handle button input.
 *                    Fill in fields in plot part of widget according
 *                    to button or key pressed.
 ***********************************************************************/

static void InputAction(w,event,params,num_params)
      Widget w;
      XEvent *event;
      String *params;         /* Unused   */
      Cardinal *num_params;   /* Unused   */
{
  PlotWidget pw;


  pw = (PlotWidget) w;

  switch(event->type)
    {
     
    case ButtonPress:
      pw->plot.InputButtonFlag = True;
      pw->plot.InputButton     = event->xbutton.button;
      pw->plot.InputX          = event->xbutton.x;
      pw->plot.InputY          = event->xbutton.y;
      break;
    case KeyPress:
      {
	int count;
	count=XLookupString((XKeyEvent *)event,
			    &(pw->plot.InputKey),
			    1,
			    &(pw->plot.InputKeysym),
			    NULL);
	if(count != 0)
	  {
	    pw->plot.InputKeyFlag    = True;
	    pw->plot.InputX          = event->xkey.x;
	    pw->plot.InputY          = event->xkey.y;
	  }
	break;
      }
    }
 
}
/************************************************************************
 * Function Name   : Redraw
 * Date            : Mon Jun 24 16:24:42 BST 1991
 * Description     : Redraw on expose
 *                   Redraw either by copying the Pixamp (Fast redraw)
 *                   or by replaying the replay buffer.
 ***********************************************************************/

static void Redraw(w,event,region)
     Widget w;
     XEvent *event;
     Region region;
{
  PlotWidget pw;

  pw = (PlotWidget)w;
  pw->plot.IsMapped++;
  if(pw->plot.FastRedraw)
    {
      XCopyArea(XtDisplay(w),pw->plot.dr,XtWindow(w),
                pw->plot.CopyGC,
                0,0,pw->core.width,
		pw->core.height,0,0);
    }
  else
    Plot_ReplayGraphics(w);
  
}
/************************************************************************
 * Function Name   : Resize
 * Description     : Resize on ConfigureNotify
 * Status          : 
 ***********************************************************************/

static void Resize(w)
      Widget w;

{
  PlotWidget pw;
  int dx,dy;
  int i;


  /* This works round the problem with hp 700 series wh calls resize
   * before realize
   */
  if(XtIsRealized(w) == 0)
    return;
  pw = (PlotWidget)w;
  dx = pw->core.width -1;
  dy = pw->core.height-1;
  pw->plot.RealDresy = dy;
  if(pw->plot.KeepRatio)
    {
      dx = dx < dy ? dx : dy;
      dy = dx;
    }
  pw->plot.Dresx = dx;
  pw->plot.Dresy = dy;

  /* Resize all the images */
  for(i=0;i<MAXIMAGES;i++)
    if(pw->plot.im[i].Allocated)
      { 
	Plot_ScaleImage(w,&(pw->plot.im[i]));
      }


  if(pw->plot.FastRedraw && XtIsRealized(w))
    {
      XFreePixmap(XtDisplay(w),pw->plot.pm);
      pw->plot.pm =XCreatePixmap(XtDisplay(w),DefaultRootWindow(XtDisplay(w)),
		    pw->core.width,
		    pw->core.height,
		    pw->core.depth);
      pw->plot.dr = pw->plot.pm; 
      ErasePixmap(w);
      Plot_ReplayGraphics(w);
    }
      
}

 


/************************************************************************
 * Function Name   : Realize
 * Description     : Realize procedure for the plot widget.
 ***********************************************************************/
static void Realize(w,valueMask,attributes)
register Widget w;
Mask *valueMask;
XSetWindowAttributes *attributes;
{
  XVisualInfo *vTemplate;
  PlotWidget pw;
  Display *dpy;
  int     screen;
  int     i;


  pw = (PlotWidget)w;
  dpy = XtDisplay(w);
  screen = DefaultScreen(dpy);

  InitColours(w); 
  InitGC(w);
  InitScaling(w);
  Plot_InitBuffer(w);

  for(i=0;i<MAXIMAGES;i++)
    pw->plot.im[i].Allocated=0;
  if(pw->core.depth > 1)
    {
      attributes->background_pixel = ((PlotWidget)w)->plot.myPixels[0]; 
      attributes->border_pixel     = pw->plot.myPixels[0];
    }
  else
    {
      attributes->background_pixel = WhitePixel(dpy,screen);
      attributes->border_pixel     = BlackPixel(dpy,screen);
    }
      
  attributes->cursor           = pw->plot.NormalCursor;
  *valueMask |=   CWBackPixel | CWBorderPixel | CWCursor ;


  XtCreateWindow(w , (unsigned int)InputOutput , CopyFromParent , *valueMask , attributes );
  if(pw->plot.FastRedraw)
    {
      pw->plot.pm = XCreatePixmap(XtDisplay(w),DefaultRootWindow(XtDisplay(w)),
				  pw->core.width,
				  pw->core.height,
				  pw->core.depth);
      pw->plot.dr = pw->plot.pm;
      ErasePixmap(w);
    }
  else
    pw->plot.dr = XtWindow(w);

  switch(pw->core.depth)
    {
    case 2:
    case 3:
    case 4:
    case 5:
    case 6:
    case 7:  /* Recolour the cursors as whole colormap is grabbed */
      {
	XColor fore,back;
	fore.pixel = pw->plot.CursorForeground;
	back.pixel = pw->plot.CursorBackground;
	XQueryColor(XtDisplay(pw),DefaultColormap(XtDisplay(pw),
						  DefaultScreen(XtDisplay(pw))),
		    &fore);
	XQueryColor(XtDisplay(pw),DefaultColormap(XtDisplay(pw),
						  DefaultScreen(XtDisplay(pw))),
		    &back);
	
	XRecolorCursor(XtDisplay(pw),pw->plot.NormalCursor,&fore,&back);
	XRecolorCursor(XtDisplay(pw),pw->plot.InputCursor,&fore,&back);
      }
    default: break;
    }
  pw->plot.IsMapped = 0;
}

int Plot_IsMapped(w)
     Widget w;
{
  PlotWidget pw;

  pw = (PlotWidget)w;
  return(pw->plot.IsMapped);
}
/************************************************************************
 * Function Name   : Destroy()
 * Description     : Destroy procedure for plot widget
 ***********************************************************************/
 
static void Destroy(w)
     Widget w;
{
     PlotWidget pw;
     int x,y;
     int i;
     pw = (PlotWidget)w;

     for (i=0; i<MAXCOLS; ++i) {
	 if (pw->plot.Allocated[i] == True) 
	     {
		 unsigned long pix = pw->plot.myPixels[i];
		 XFreeColors(XtDisplay(w),pw->core.colormap,
			     &pix,1,0);
		 pw->plot.Allocated[i] = False;
	     }
     }

     Plot_FreeBuffer(w);
     if(pw->plot.PrettyDestroy > 0){
       int n ;
       n =  pw->plot.PrettyDestroy;
       if(n<4)
	 n=4;
       FadeOut(w,n);
     }
     XFlush(XtDisplay(w));
     XFreeGC(XtDisplay(w),pw->plot.CopyGC);
     XFreeGC(XtDisplay(w),pw->plot.RubberBandGC);
     XFreeGC(XtDisplay(w),pw->plot.EraseGC);
     if(pw->plot.FastRedraw)
       XFreePixmap(XtDisplay(w),pw->plot.pm);

}



PlotClassRec plotClassRec = {
  { /* core fields */
    /* superclass		*/	(WidgetClass) &widgetClassRec,
    /* class_name		*/	"Plot",
    /* widget_size		*/	sizeof(PlotRec),
    /* class_initialize		*/	NULL,
    /* class_part_initialize	*/	NULL,
    /* class_inited		*/	FALSE,
    /* initialize		*/	NULL,
    /* initialize_hook		*/	NULL,
    /* realize			*/	Realize,
    /* actions			*/	actions,
    /* num_actions		*/	XtNumber(actions),
    /* resources		*/	resources,
    /* num_resources		*/	XtNumber(resources),
    /* xrm_class		*/	NULLQUARK,
    /* compress_motion		*/	TRUE,
    /* compress_exposure	*/	TRUE,
    /* compress_enterleave	*/	TRUE,
    /* visible_interest		*/	FALSE,
    /* destroy			*/	Destroy,
    /* resize			*/	Resize,
    /* expose			*/	Redraw,
    /* set_values		*/	NULL,
    /* set_values_hook		*/	NULL,
    /* set_values_almost	*/	XtInheritSetValuesAlmost,
    /* get_values_hook		*/	NULL,
    /* accept_focus             */      NULL,
    /* version			*/	XtVersion,
    /* callback_private		*/	NULL,
    /* tm_table			*/	translations,
    /* query_geometry		*/	XtInheritQueryGeometry,
    /* display_accelerator	*/	XtInheritDisplayAccelerator,
    /* extension		*/	NULL
  },
  { /* plot fields */
    /* empty			*/	0
  }
};

WidgetClass plotWidgetClass = (WidgetClass)&plotClassRec;


/************************************************************************
 * Function Name   : InitColours
 * Description     : Initialize the colour map for the plot widget.
 *                   Default to no allocated cells and create the screen
 *                   colourmap.
 ***********************************************************************/
 
static XVisualInfo *InitColours(w)
     Widget w;
{
  int i,visualsMatched;
  PlotWidget pw;
  XVisualInfo *visualList,vTemplate;
  Display *dpy;
 
  pw = (PlotWidget)w;
  dpy = XtDisplay(w);
  /* 1.  Set up colour allocation table to None allocated */
  for(i=0;i<MAXCOLS;i++)
    {
      pw->plot.Allocated[i] = False;
      pw->plot.ReadWrite[i] = False;
 
    }

  /* 2. Set colour 0 to be the background colour          */
  Plot_DefineColour(w,0,0,0,0);

  pw->plot.ColorsChanged = False;

}

/************************************************************************
 * Function Name   : InitGC()
 * Description     : Set up the graphics GCs for the plot widget
 *                   Two GC's are created and lodged in the widget
 *                   data structure, namely a CopyGC for normal 
 *                   graphics, and a Rubber-band GC using the Xor
 *                   function, for rubber band graphics. The rubber
 *                   band line is erased by re-drawing it.
 ***********************************************************************/
static void InitGC(w)
     Widget w;
{
  PlotWidget pw;
  XGCValues  val;
  unsigned int myMask;
  Display *mydisplay;
  int myscreen,mybackground,myforeground;

  pw = (PlotWidget)w;

  mydisplay    = XtDisplay(w);
  myscreen     = DefaultScreen(mydisplay);
  mybackground = WhitePixel(mydisplay,myscreen);
  myforeground = BlackPixel(mydisplay,myscreen);

  
  val.foreground = pw->plot.foreground;
  val.background = pw->plot.background;
  val.font       = pw->plot.font->fid;
  val.function   = GXcopy;
  myMask           = GCForeground | GCBackground | GCFont | GCFunction;
  pw->plot.CopyGC        = XtGetGC( w, myMask , &val);
  val.function           = GXxor;
  pw->plot.RubberBandGC  = XtGetGC( w, myMask , &val);
  val.function           = GXclear;
  pw->plot.EraseGC       = XtGetGC( w, myMask , &val);

  if(pw->core.depth == 1)
  {
    XSetBackground(mydisplay,pw->plot.CopyGC,mybackground);
    XSetBackground(mydisplay,pw->plot.RubberBandGC,mybackground);
    XSetForeground(mydisplay,pw->plot.CopyGC,myforeground);
    XSetForeground(mydisplay,pw->plot.RubberBandGC,myforeground);
  }


}
			    
/************************************************************************
 * Function Name   : InitScaling()
 * Description     : Set up the scaling for the plot widget.
 ***********************************************************************/
#define Min(x,y) x<y ? x : y
static void InitScaling(w)
     Widget w;
{
  PlotWidget pw;
  int dx,dy;

  pw = (PlotWidget)w;
  dx = pw->core.width -1;
  dy = pw->core.height-1;
  pw->plot.RealDresy = dy;
  if(pw->plot.KeepRatio)
    {
      dx = Min(dx,dy);
      dy = Min(dx,dy);
    }
  pw->plot.Dresx = dx;
  pw->plot.Dresy = dy;

}
			    
/************************************************************************
 * Function Name   : ErasePixmap
 * Description     : Erase the pixmap for the fast redraw 
 ***********************************************************************/
 
static void ErasePixmap(w)
     Widget w;
{
  PlotWidget pw;

  pw = (PlotWidget) w;
  XFillRectangle(XtDisplay(w),pw->plot.pm,pw->plot.EraseGC,0,0,
		 pw->core.width,
		 pw->core.height);
}
/************************************************************************
 * Function Name   : FadeOut
 * Description     : Pretty destroy sequence for plot widget
 ***********************************************************************/
static void FadeOut(w,n)
     Widget w;
     int    n;
{
  int *pixorder,i,irand;
  int width,height,nwidth,nheight,npixels;
  PlotWidget pw;
  pw      = (PlotWidget)w;
  width   =  pw->core.width;
  height  =  pw->core.height;
  nwidth  =  (width/n) ;
  nheight =  (height/n);
  npixels =  nwidth*nheight;
  irand   =  npixels;
  pixorder=  (int *) XtMalloc(npixels*sizeof(int));
  for(i=0;i<npixels;i++)
    pixorder[i] = i;
  for(i=0;i<npixels;i++)
    {
      int rand,temp;
      rand = (randnum(irand))%npixels;
      temp           = pixorder[i];
      pixorder[i]    = pixorder[rand];
      pixorder[rand] = temp;
    }
  for(i=0;i<npixels;i++)
    {
      int xor,yor,r;
      r = pixorder[i];
      yor = n*(r / nwidth);
      xor = n*(r - nwidth*(yor/n));
      XClearArea(XtDisplay(w),XtWindow(w),xor,yor,n,n,False);
    }
  XtFree((char *)pixorder);
}
