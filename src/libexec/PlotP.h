/************************************************************************
 * Application: Plot class widget
 * File       : PlotP.h
 * Author     : I.G.D.Strachan - Harwell Instruments
 * Date       : 4/3/92
 * Version    : 1.2
 * Description: Private header file for the Plot class widget.
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
 *
 * Status     : Released
 * QA check   : 
 * QA date    :
 ***********************************************************************/

/****************  INCLUDES             ********************************/
#ifndef _PlotP_h
#define _PlotP_h

#include "Plot.h"
/* include superclass private header file */
#include <X11/CoreP.h>


/****************  COMPILER DIRECTIVES  ********************************/
#define MAXCOLS     256
#define CHUNKSIZE   2048
#define MAXIMAGES   100

/****************  TYPE DEFINITIONS     ********************************/

/************************** Class record ***********************/
/*** Plot Class part ***/
typedef struct {
    int empty;
} PlotClassPart;


/*** Plot class record ***/
typedef struct _PlotClassRec {
    CoreClassPart	core_class;
    PlotClassPart	plot_class;
} PlotClassRec;

extern PlotClassRec plotClassRec;

/************************* Plot widget data record *************/

/**************************************************
 * The replay buffer. This is implemented as a 
 * series of chunks of data. The set of chunks
 * is implemented as a linked list
 */
typedef struct _replayChunk
{
  struct _replayChunk *Next;
  int                 data[CHUNKSIZE];
}replayChunk;

/**************************************************
 * Image data
 */

typedef struct 
{
  int Allocated;
  int Width,Height;
  int x1,y1,x2,y2;      /* User requested coordinates */
  int tx1,ty1,tx2,ty2;    /* transformed coordinates  */
  char *ImageRawData;     /* Raw data sent by the user*/
  XImage *Image;          /* The actual image to be put*/
  int startColour;
  int endColour;
}PlotImage;
/*** Plot widget data record ***/
typedef struct {
    /* resources */
    char*          resource;
    Pixel          foreground;
    Pixel          background;
    Cursor         InputCursor;
    Cursor         NormalCursor;
    int            CursorForeground;
    int            CursorBackground;

    Bool           FastRedraw;
    Bool           KeepRatio;
    int            PrettyDestroy;   

    XFontStruct   *font;
    /* private state */

    /* Drawing stuff */
    Pixmap         pm;
    Drawable       dr;
    GC             CopyGC;
    GC             RubberBandGC;
    GC             EraseGC;

    /* Colormap stuff  */
    Pixel          myPixels[MAXCOLS];
    Bool           Allocated[MAXCOLS];
    Bool           ReadWrite[MAXCOLS];
    Bool           ColorsChanged;

    /* Replay buffer stuff */
    replayChunk    *currentChunk;
    int            chunkPtr;
    replayChunk    *replayBuffer;
    int            MaxChunks;
    int            NumChunks;
    int            BufferFull;
    /* Scaling stuff */
    int            Dresx;
    int            Dresy;
    int            RealDresy;

    /* Input Action stuff  */
    int            InputKeyFlag;
    int            InputButtonFlag;
    char           InputKey;
    int            InputButton;
    KeySym         InputKeysym;
    int            InputX;
    int            InputY;

    /* Misc              */
    int            IsMapped;
    PlotImage      im[MAXIMAGES];

} PlotPart;

typedef struct _PlotRec {
    CorePart		core;
    PlotPart	        plot;
} PlotRec;


/****************  MACROS               ********************************/
/* define unique representation types not found in <X11/StringDefs.h> */

#define XtRPlotResource		"PlotResource"


/* Definition of replay buffer opcodes */

#define RPB_LINK       -1           /* Go to next chunk   */
#define RPB_END        -2           /* Buffer end marker  */
#define RPB_POLYLINE   0x2001
#define RPB_POLYMARK   0x2002
#define RPB_FILLPOLY   0x2003
#define RPB_TEXT       0x2004
#define RPB_SETFC      0x2005  
#define RPB_PUTIMAGE   0x2006

/****************  GLOBAL VARIABLES     ********************************/
/****************  STATIC VARIABLES     ********************************/
static char PlotP_hSID[] = "@(#)PlotP.h	1.2 4/3/92";


#endif /* _PlotP_h */
