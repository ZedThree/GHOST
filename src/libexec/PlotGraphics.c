/************************************************************************
 * Application: Plot Class widget
 * File       : PlotGraphics.c
 * Author     : I.G.D.Strachan
 * Date       : 4/3/92
 * Version    : 1.1
 * Description: General graphics functions for plot class widget.
 *
 *
 * Status     : Released
 * QA check   : 
 * QA date    :
 ***********************************************************************/
#include <X11/IntrinsicP.h>
#include <X11/StringDefs.h>
#ifdef _WIN32
#include <X11/xlibxtra.h>
#endif
#include "PlotP.h"
#include <stdio.h>
/****************  INCLUDES             ********************************/
/****************  COMPILER DIRECTIVES  ********************************/
/****************  TYPE DEFINITIONS     ********************************/
/****************  MACROS               ********************************/

#define DRAWABLE   (pw->plot.dr)

/****************  GLOBAL VARIABLES     ********************************/
/****************  STATIC VARIABLES     ********************************/
static char PlotGraphics_cSID[] = "@(#)PlotGraphics.c	1.1 4/3/92";
/****************  FUNCTION PROTOTYPES  ********************************/
static void TransformCoordinates();
void        Plot_DefineColour();
void        Plot_SetForeground();
void        Plot_PolyLine();
void        Plot_PolyMark();
void        Plot_FillPoly();
void        Plot_Text();
void        Plot_Erase();
void        Plot_GetInput();
void        Plot_ReplayGraphics();
void        Plot_Flush();
void        Plot_DefineImage();
void        Plot_PutImage();

/****************  FUNCTIONS            ********************************/

/************************************************************************
 * Function Name   : Plot_DefineColour
 * Description     : Define a colour in the widget's colourmap.
 *                   If a read/write cell has been allocated already
 *                   just store the new colour.
 *                   Otherwise try to allocate a new read-only colour cell
 *                   and colour and fall back to allocating a read/write 
 *                   colour cell if thi fails. If a new read-only colour cell
 *                   is being used for the background (colour 0) set the window
 *                   background colour. If a new read-only colour cell
 *                   is being used set a flag to indicate that the screen
 *                   needs to be replayed.
 ***********************************************************************/
void Plot_DefineColour(w,ColNum,Red,Green,Blue)
     Widget w;
{
  XColor Col;
  PlotWidget pw;
  unsigned long plane_masks,pix;

  pw = (PlotWidget)w;
  Col.red   = Red   << 8;
  Col.green = Green << 8;
  Col.blue  = Blue  << 8;
  Col.flags = DoRed | DoGreen | DoBlue;

  if (pw->plot.Allocated[ColNum] == True &&
      pw->plot.ReadWrite[ColNum] == True) 
      {
	  Col.pixel = pw->plot.myPixels[ColNum];
	  XStoreColors(XtDisplay(w),pw->core.colormap, &Col,1);
      }
  else
      {
	  if (pw->plot.Allocated[ColNum] == True &&
	      pw->plot.ReadWrite[ColNum] == False) 
	      {
		  pix = pw->plot.myPixels[ColNum];
		  XFreeColors(XtDisplay(w),pw->core.colormap,
			      &pix,1,0);
		  pw->plot.Allocated[ColNum] = False;
	      }
	  if (XAllocColor(XtDisplay(w),pw->core.colormap,&Col)) 
	      {
		  pw->plot.myPixels[ColNum] = Col.pixel;
		  pw->plot.Allocated[ColNum] = True;
		  pw->plot.ReadWrite[ColNum] = False;
		  pw->plot.ColorsChanged = True;
		  if ( XtIsRealized(w) ) {
		      if ( ColNum == 0 ) 
			  XSetWindowBackground(XtDisplay(w),XtWindow(w),Col.pixel);
		  }
	      } 
	  else if (XAllocColorCells(XtDisplay(w),pw->core.colormap,False,
				    &plane_masks,0,&pix,1)) 
	      {
		  Col.pixel = pix;
		  XStoreColors(XtDisplay(w),pw->core.colormap , &Col,1);
		  pw->plot.myPixels[ColNum] = Col.pixel;
		  pw->plot.Allocated[ColNum] = True;
		  pw->plot.ReadWrite[ColNum] = True;
	      } 
	  else 	      
	      {
		  Display* dpy = XtDisplay(w);
		  int screen_num = DefaultScreen(dpy);
#ifdef _WIN32
	     printf(
#else
         fprintf(stderr,
#endif
			   "Ghost 80: Could not allocate colour\n");
#ifdef _WIN32
	     printf(
#else
	     fprintf(stderr,
#endif
			   "          Plotting in black or white\n");
		  if ( ColNum == 0) 
		      pw->plot.myPixels[ColNum] = BlackPixel(dpy,screen_num);
		  else
		      pw->plot.myPixels[ColNum] = WhitePixel(dpy,screen_num);
		  pw->plot.Allocated[ColNum] = False;
		  pw->plot.ReadWrite[ColNum] = False;
		  pw->plot.ColorsChanged = True;
	      }
      }
}
/************************************************************************
 * Function Name   : Plot_SetForeground()
 * Description     : Set the foreground colour.
 *                   NB if this colour has not yet ben defined it is
 *                   defined to be black by calling Plot_DefineCiolour()
 ***********************************************************************/
 
void Plot_SetForeground(w,col)
     Widget w;
     int col;
{
  PlotWidget pw = (PlotWidget) w;
  Pixel pix;

  
  Plot_ToBuffer(w , RPB_SETFC , 1 , &col);
  if (pw->plot.Allocated[col] == False)
    Plot_DefineColour(w,col,0,0,0);

  pix = pw->plot.myPixels[col];
  XSetForeground( XtDisplay(w), pw->plot.CopyGC       , pix );
  XSetForeground( XtDisplay(w), pw->plot.RubberBandGC , pix );
} 

/************************************************************************
 * Function Name   : Plot_PolyLine()
 * Description     : Draw an open polyline (arrays xp & yp)
 ***********************************************************************/

void Plot_PolyLine(w,xp,yp,np)
     Widget w;
     int    *xp,
            *yp,
            np;
{
  PlotWidget pw;
  static XPoint thePoints[CHUNKSIZE-4];
  XPoint *tp;
  int i,Length;
  short xtemp,ytemp;
  
  pw = (PlotWidget) w;

 /* 1. Save untransformed coords into XPoint buffer and save to ReplayBuffer */
  tp = thePoints;
  for(i=0;i<np;i++)
    {
      tp->x = *xp;
      tp->y = *yp;
      tp++;
      xp++;
      yp++;
    }
  Length = (np*sizeof(XPoint))/sizeof(int);
  Plot_ToBuffer(w,RPB_POLYLINE,Length,thePoints);


 /* 2. Transform coordinates and plot */
  TransformCoordinates(pw,thePoints,np);
  XDrawLines(XtDisplay(w),DRAWABLE,
             pw->plot.CopyGC,
             thePoints,np,CoordModeOrigin);
}

/************************************************************************
 * Function Name   : Plot_PolyMark
 * Description     : Plot multiple points
 ***********************************************************************/
 
void Plot_PolyMark(w,xp,yp,np)
     Widget w;
     int    *xp,
            *yp,
            np;
{
  PlotWidget pw;
  static XPoint thePoints[CHUNKSIZE-4];
  XPoint *tp;
  int i,Length;
  short xtemp,ytemp;
  
  pw = (PlotWidget) w;

 /* 1. Save untransformed coords into XPoint buffer and save to ReplayBuffer */
  tp = thePoints;
  for(i=0;i<np;i++)
    {
      tp->x = *xp;
      tp->y = *yp;
      tp++;
      xp++;
      yp++;
    }
  Length = (np*sizeof(XPoint))/sizeof(int);
  Plot_ToBuffer(w,RPB_POLYMARK,Length,thePoints);


 /* 2. Transform coordinates and plot */
  TransformCoordinates(pw,thePoints,np);
  XDrawPoints(XtDisplay(w),DRAWABLE,
             pw->plot.CopyGC,
             thePoints,np,CoordModeOrigin);
}





/************************************************************************
 * Function Name   : Plot_FillPoly()
 * Description     : Draw an filled polygon (arrays xp & yp)
 ***********************************************************************/


void Plot_FillPoly(w,xp,yp,np)
     Widget w;
     int    *xp,
            *yp,
            np;
{
  PlotWidget pw;
  static XPoint thePoints[CHUNKSIZE-4];
  XPoint *tp;
  int i,drx,dry,odrx,odry,rdry,Length;
  short xtemp,ytemp;
  
  pw = (PlotWidget) w;

 /* 1. Save untransformed coords into XPoint buffer and save to ReplayBuffer */
  tp = thePoints;
  for(i=0;i<np;i++)
    {
      tp->x = *xp;
      tp->y = *yp;
      tp++;
      xp++;
      yp++;
    }
  Length = (np*sizeof(XPoint))/sizeof(int);
  Plot_ToBuffer(w,RPB_FILLPOLY,Length,thePoints);

 /* 2. Transform and plot the coordinates */
  TransformCoordinates(pw,thePoints,np);
  XFillPolygon(XtDisplay(w),DRAWABLE,
	       pw->plot.CopyGC,
	       thePoints,np,Complex,CoordModeOrigin);
  XDrawLines(XtDisplay(w),DRAWABLE,
             pw->plot.CopyGC,
             thePoints,np,CoordModeOrigin);
}

/***********************************************************************
 * Function Name   :  Plot_Text()
 * Description     :  Plot a string of text in the current font
 ***********************************************************************/
 
void Plot_Text(w,x,y,text)
     Widget w;
     int x,y;
     char *text;
{
  PlotWidget pw;
  int Data[CHUNKSIZE];
  char *datp;
  int len,Length;
  XPoint p;

   pw = (PlotWidget) w;
  /* 1. Format in RPB is <x> <y> <len> <text> 
   *    text is flushed to nearest int sized word
   */
  len = strlen(text);
  Data[0] = x;
  Data[1] = y;
  Data[2] = len;
  /* 2. Pack the chars in */
  datp = (char*) (&Data[3]);
  strcpy(datp,text);

  if( len % sizeof(int) == 0)
    Length = len/sizeof(int) + 3;
  else
    Length = len/sizeof(int) + 4;

  /* Save in the buffer and actually draw the string */
  Plot_ToBuffer(w,RPB_TEXT,Length,Data);
  p.x = x;
  p.y = y;
  TransformCoordinates(w,&p,1);
  p.x = p.x - 3;
  p.y = p.y + 5;
  XDrawString(XtDisplay(w),DRAWABLE,pw->plot.CopyGC,p.x,p.y,text,len);
}

/************************************************************************
 * Function Name   : Plot_Erase
 * Description     : Clear the current window and free up the 
 *                   replay buffer
 ***********************************************************************/
 
void Plot_Erase(w)
     Widget w;
{
  XClearWindow(XtDisplay(w),XtWindow(w));
  Plot_FreeBuffer(w);
}
/************************************************************************
 * Function Name   : Plot_GetInput
 * Description     : Get results of latest input action on widget
 *                   Returns :-
 *                   Type =1 -> Button   =2 -> Key
 *                   Key     Ascii code of key pressed (Type = 2)
 *                   Button  Button No. pressed (Type = 1)
 *                   Xcoord,Ycoord (Window coords of pointer)
 ***********************************************************************/

void Plot_GetInput(w,Type,Key,Button,Xcoord,Ycoord)
     Widget w;
     int *Type;
     char *Key;
     int *Button;
     int *Xcoord,*Ycoord;
{
  PlotPart *p;
  int odry,rdry,dry;

  p = & ( ((PlotWidget) w)->plot );
  Plot_Flush(w);
  p->InputKeyFlag    = False;
  p->InputButtonFlag = False;
  XDefineCursor(XtDisplay(w),XtWindow(w),p->InputCursor);

  while( (p->InputKeyFlag == False) && (p->InputButtonFlag == False))
    XtAppProcessEvent(XtWidgetToApplicationContext(w),XtIMXEvent);


  dry  = p->Dresy;
  rdry = p->RealDresy;
  *Xcoord = (16384*p->InputX)/p->Dresx;
  *Ycoord = 16384*(p->RealDresy - p->InputY)/p->Dresy;
  if(p->InputKeyFlag)
    {
      *Type   = 2;
      *Key    = p->InputKey;
    }
  else
    {
      *Type   = 1;
      *Button = p->InputButton;
    }
  XDefineCursor(XtDisplay(w),XtWindow(w),p->NormalCursor);
  XFlush(XtDisplay(w));
}

/************************************************************************
 * Function Name   :  Plot_ReplayGraphics
 * Description     :  Replay all the data in the Replay buffer.
 *                    Do this on expose events.
 ***********************************************************************/

void Plot_ReplayGraphics(w)
     Widget w;
{
  int Data[CHUNKSIZE];
  int OpCode,Length;
  PlotWidget pw = (PlotWidget) w;

  pw->plot.currentChunk = pw->plot.replayBuffer;
  pw->plot.chunkPtr     = 0;

  while(Plot_FromBuffer(w,&OpCode,&Length,Data))
    {
      switch(OpCode)
	{
	case RPB_SETFC:
	  {
	    int pix;

	    pix = pw->plot.myPixels[Data[0]];
	    XSetForeground( XtDisplay(w), pw->plot.CopyGC       , pix );
	    XSetForeground( XtDisplay(w), pw->plot.RubberBandGC , pix );
	    break;
	  }
	case RPB_POLYLINE:
	  {
            XPoint *tp;
	    int np;

	    tp = (XPoint *) Data;
	    np = (Length*sizeof(int))/sizeof(XPoint);
            TransformCoordinates(pw,tp,np);
	    XDrawLines(XtDisplay(w),DRAWABLE,
		       pw->plot.CopyGC,
		       tp,np,CoordModeOrigin);
	    break;
	  }
	case RPB_POLYMARK:
	  {
            XPoint *tp;
	    int np;

	    tp = (XPoint *) Data;
	    np = (Length*sizeof(int))/sizeof(XPoint);
            TransformCoordinates(pw,tp,np);
	    XDrawPoints(XtDisplay(w),DRAWABLE,
		       pw->plot.CopyGC,
		       tp,np,CoordModeOrigin);
	    break;
	  }
	case RPB_FILLPOLY:
  
	  {
            XPoint *tp;
	    int np;

	    tp = (XPoint *) Data;
	    np = (Length*sizeof(int))/sizeof(XPoint);
            TransformCoordinates(pw,tp,np);
	    XFillPolygon(XtDisplay(w),DRAWABLE,
		      pw->plot.CopyGC,
		      tp,np,Complex,CoordModeOrigin);
	    XDrawLines(XtDisplay(w),DRAWABLE,
		       pw->plot.CopyGC,
		       tp,np,CoordModeOrigin);
	    break;
	  }

	case RPB_TEXT:
	  { 
	    int x,y,len;
	    char *text;
            XPoint p;
	    p.x   = Data[0];
	    p.y   = Data[1];
	    len = Data[2];
	    text= (char *)(&Data[3]);
            TransformCoordinates(w,&p,1);
            p.x = p.x - 3;
            p.y = p.y + 5;
	    XDrawString(XtDisplay(w),DRAWABLE,
			pw->plot.CopyGC,
			p.x,p.y,
			text,len);
	    break;
	  }
	case RPB_PUTIMAGE:
	  {
	    PlotImage *pi;
	    pi = &(pw->plot.im[Data[0]]);
	    
	    XPutImage( XtDisplay(w),
		      XtWindow(w),
		      pw->plot.CopyGC,
		      pi->Image,
		      0,0,
		      pi->tx1,pi->ty2,
		      1+pi->tx2-pi->tx1,
		      1+abs(pi->ty2-pi->ty1));
	    break;
	  }

	}
    }
}

/************************************************************************
 * Function Name   : TransformCoordinates
 * Description     : Transform raw data to scale into the current window 
 *                   size.
 ***********************************************************************/
static void TransformCoordinates(pw,points,np)
     PlotWidget pw;
     XPoint    *points;
     int        np;
{
  int i,drx,dry,rdry,Length;
  long xtemp,ytemp;

  drx = pw->plot.Dresx;
  dry = pw->plot.Dresy;
  rdry= pw->plot.RealDresy;
  
  for(i=0;i<np;i++)
    { 
      xtemp = (long) points->x;
      ytemp = (long) points->y;
      
      xtemp = (drx*xtemp) >> 14;
      ytemp = (dry*ytemp) >> 14;
      
      
      points->x = (int) xtemp;
      points->y = (int) (rdry - ytemp);
      
      points++;
    }
}

/************************************************************************
 * Function Name   :  PlotFlush
 * Description     :  Flush the X display and if necessary, copy the 
 *                    pixmap to the window.
 ***********************************************************************/
void Plot_Flush(w)
     Widget w;
{
  PlotWidget pw;

  pw = (PlotWidget)w;

  if (pw->plot.ColorsChanged) {
      XClearWindow(XtDisplay(w),XtWindow(w));
      Plot_ReplayGraphics(w);
      pw->plot.ColorsChanged = False;
  }

  XFlush(XtDisplay(w));
  if(pw->plot.FastRedraw)
    {
      XCopyArea(XtDisplay(w),pw->plot.pm,XtWindow(w),
		pw->plot.CopyGC,
                0,0,
		pw->core.width,
		pw->core.height,
		0,0);
    }
}
/************************************************************************
 * Function Name   : Plot_ScaleImage
 * Description     : Rescale an image on resize event. This is done
 *                   by pixel replication, using a variant of the 
 *                   Bresenham line algorithm.
 ***********************************************************************/

void Plot_ScaleImage(w,pi)
     Widget w;
     PlotImage *pi;
{
  PlotWidget pw;
  XPoint p[2];
  int ImWidth,ImHeight;
  Display *dpy;
  int screen;
  Visual *vis;
  int Colours[256];
  pw = (PlotWidget)w;
  /* 1. Transform the coordinates to screen coordinates */
  p[0].x = (short)pi->x1;
  p[0].y = (short)pi->y1;
  p[1].x = (short)pi->x2;
  p[1].y = (short)pi->y2;

  TransformCoordinates(pw,p,2);
  pi->tx1 = (int)p[0].x;
  pi->ty1 = (int)p[0].y;
  pi->tx2 = (int)p[1].x;
  pi->ty2 = (int)p[1].y;
  ImWidth = abs(pi->tx2 - pi->tx1) + 1;
  ImHeight= abs(pi->ty2 - pi->ty1) + 1;


  /* 2. Free old image structure  */
  if(pi->Allocated)
    {
      XFree(pi->Image->data);
      XFree(pi->Image);
    }

  /* 3. Allocate new image structure */
  dpy = XtDisplay(w);
  screen = DefaultScreen(dpy);
  vis    = DefaultVisual(dpy,screen); /* Should not this be in the struct ?? */
  pi->Image = XCreateImage(dpy,vis,8,ZPixmap,0,0,ImWidth,ImHeight,8,0);
  pi->Image->data = (char *)malloc(pi->Image->bytes_per_line*ImHeight); 
  pi->Allocated = 1;

  /* 4. Scale the image from the raw data */
  {
    int i,iControl,j,jControl,val;
    unsigned char *ptr,*oldptr,*dptr;
    int Colours[256];
    int scol,ecol,ncols,control;

    /* 4.1 Compute linearly scaled colour table between defined colours */
    scol = pi->startColour;
    ecol = pi->endColour;
    ncols = (ecol-scol)+1;
    control=0;

    for(i=0;i<256;i++)
      {
	Colours[i] = scol;
	control += ncols;
	if(control >= 256)
	  {
	    control -= 256;
	    scol++;
	  }
      }
 
    /* 4.2 Construct the necessary X image      */
    ptr    = (unsigned char*)(pi->ImageRawData);
    oldptr = ptr;
    dptr   = (unsigned char*)(pi->Image->data);
    for(i=0,iControl=0;i<ImHeight;i++)
      {
	for(j=0,jControl=0;j<ImWidth;j++)
	  {
	    val = *ptr;
	    val = (int)(pw->plot.myPixels[Colours[val]]);
/*	    XPutPixel(pi->Image,i,j,val);     */
	    dptr[j] = val; 
	    jControl += pi->Width;
	    if(jControl > ImWidth)
	      {
		while(jControl > ImWidth)
		  {
		    jControl -= ImWidth;
		    ptr++;
		  }
	      }

	  }
	iControl += pi->Height;
	
	if(iControl > ImHeight)
	  {
	    while(iControl > ImHeight)
	      {
		iControl -= ImHeight;
		oldptr += pi->Width;
	      }
	  }
	ptr = oldptr;
	dptr += pi->Image->bytes_per_line;
      }
  }
  pi->Allocated = 1;
}

/************************************************************************
 * Function Name   : Plot_DefineImage
 * Date            : Mon Nov 4 16:18:51 GMT 1991
 * Description     : Define an image. Given widget,image number,etc.
 ***********************************************************************/
 
void Plot_DefineImage(W,id,x1,y1,x2,y2,w,h,startColour,endColour,data)
     Widget W;
     int id,x1,y1,x2,y2,w,h,startColour,endColour;
     char *data;
{

  PlotImage *pi;
  PlotWidget pw;
  int i;


  if(id<0 || id >MAXIMAGES)
    return;
  
  pw = (PlotWidget)W;
  pi = &(pw->plot.im[id]);

  pi->Width       = w;
  pi->Height      = h;
  pi->x1          = x1;
  pi->y1          = y1;
  pi->x2          = x2;
  pi->y2          = y2;
  pi->startColour = startColour;
  pi->endColour   = endColour;


/* Copy the raw data into structure */
  if(pi->Allocated )
    {
      XtFree(pi->ImageRawData);
    }
  pi->ImageRawData = XtMalloc(w*h);
  for(i=w*h-1;i>=0;i--)
    pi->ImageRawData[i] = data[i];
  
  Plot_ScaleImage(W,pi);
}

/************************************************************************
 * Function Name   : Plot_PutImage
 * Description     : Draw the given image ID at the requested place
 ***********************************************************************/

void Plot_PutImage(w,id)
     Widget w;
     int id;
{
  PlotWidget pw;
  PlotImage  *pi;


  
  pw = (PlotWidget) w;
  if(id < 0 || id >= MAXIMAGES)
    return;
  
  Plot_ToBuffer(w,RPB_PUTIMAGE,1,&id);
  pi = &(pw->plot.im[id]);
  if(!pi->Allocated)
    return;

  XPutImage( XtDisplay(w),
	     XtWindow(w),
	     pw->plot.CopyGC,
	     pi->Image,
	     0,0,
             pi->tx1,pi->ty2,
	     1+pi->tx2-pi->tx1,
	     1+abs(pi->ty2-pi->ty1));
}
