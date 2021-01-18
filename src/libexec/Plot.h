/************************************************************************
 * Application: Plot class widget
 * File       : Plot.h
 * Author     : I.G.D.Strachan
 * Date       : 4/3/92
 * Version    : 1.2
 * Description: Public header file for plot widget
 *
 *
 * Status     : Released
 * QA check   : 
 * QA date    :
 ***********************************************************************/

static char Plot_hSID[] = "@(#)Plot.h	1.2 4/3/92";



/* $XConsortium: Template.h,v 1.2 88/10/25 17:22:09 swick Exp $ */
/* Copyright	Massachusetts Institute of Technology	1987, 1988 */

#ifndef _Plot_h
#define _Plot_h

/****************************************************************
 *
 * Plot widget
 *
 ****************************************************************/

/* Resources:

 Name		     Class		RepType		Default Value
 ----		     -----		-------		-------------
 background	     Background		Pixel		XtDefaultBackground
 border		     BorderColor	Pixel		XtDefaultForeground
 borderWidth	     BorderWidth	Dimension	1
 destroyCallback     Callback		Pointer		NULL
 height		     Height		Dimension	0
 mappedWhenManaged   MappedWhenManaged	Boolean		True
 sensitive	     Sensitive		Boolean		True
 width		     Width		Dimension	0
 x		     Position		Position	0
 y		     Position		Position	0
 callback            Callback           Callback        NULL
 exposeCallback      Callback           Callback        NULL
 inputCursor         Cursor             Cursor          "cross_hair"
 normalCursor        Cursor             Cursor          "diamond_cross"
 fastRedraw          Boolean            Boolean         False
 keepRatio           Boolean            Boolean         True
 prettyDestroy       Value              Int             0
*/

/* define any special resource names here that are not in <X11/StringDefs.h> */

#define XtNplotResource		"plotResource"

#define XtCPlotResource		"PlotResource"
#define XtNinputCursor          "InputCursor"
#define XtNnormalCursor         "NormalCursor"
#define XtNfastRedraw           "FastRedraw"
#define XtNkeepRatio            "KeepRatio"
#define XtNprettyDestroy        "PrettyDestroy"
#define XtNmaxChunks            "MaxChunks"
#define XtNcursorForeground     "CursorForeground"
#define XtNcursorBackground     "CursorBackground"



/* declare specific PlotWidget class and instance datatypes */

typedef struct _PlotClassRec*	        PlotWidgetClass;
typedef struct _PlotRec*		PlotWidget;

/* declare the class constant */

extern WidgetClass plotWidgetClass;

#endif /*  _Plot_h  */
