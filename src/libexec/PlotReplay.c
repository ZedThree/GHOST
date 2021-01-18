/************************************************************************
 * Application: Plot class widget
 * File       : PlotReplay.c
 * Author     : I.G.D.Strachan
 * Date       : 4/3/92
 * Version    : 1.2
 * Description: Implementation for the Plot widget replay buffer
 *
 *
 * Status     : Released (1.1)
 * QA check   : 
 * QA date    :
 ***********************************************************************/

/****************  INCLUDES             ********************************/
#include <stdio.h>
#include <X11/IntrinsicP.h>
#include <X11/StringDefs.h>
#ifdef _WIN32
#include <X11/xlibxtra.h>
#endif
#include "PlotP.h"
/****************  COMPILER DIRECTIVES  ********************************/
/****************  TYPE DEFINITIONS     ********************************/
/****************  MACROS               ********************************/

/****************  GLOBAL VARIABLES     ********************************/
/****************  STATIC VARIABLES     ********************************/
static char PlotReplay_cSID[] = "@(#)PlotReplay.c	1.2 4/3/92";
/****************  FUNCTION PROTOTYPES  ********************************/
void Plot_InitBuffer();
void Plot_DumpBuffer();
void FreeBuffer();
void Plot_FreeBuffer();
void Plot_ToBuffer();
int Plot_FromBuffer();
/****************  FUNCTIONS            ********************************/

/************************************************************************
 * Function Name   :  Plot_InitBuffer()
 * Description     :  Set up initial buffer for Plot widget
 ***********************************************************************/
 
void Plot_InitBuffer(w)
     Widget w;
{
  PlotWidget pw;
  
  pw = (PlotWidget)w;
  pw->plot.replayBuffer       = XtNew(replayChunk);
  pw->plot.currentChunk       = pw->plot.replayBuffer;
  pw->plot.chunkPtr           = 0;
  pw->plot.replayBuffer->Next = NULL;
  pw->plot.replayBuffer->data[0] = RPB_END;
  pw->plot.NumChunks          = 0;
  pw->plot.BufferFull         = 0;
}

/************************************************************************
 * Function Name   :  Plot_DumpBuffer()
 * Description     :  Dump the replay buffer to file
 ***********************************************************************/

void Plot_DumpBuffer(w, filename)
     Widget w;
     char *filename;
{
  PlotWidget pw;
  FILE *outfile;
  replayChunk *r;  
  pw = (PlotWidget)w;

  r = pw->plot.replayBuffer;
  outfile = fopen(filename,"w");

  while(r->Next)
    {
      fwrite(r->data,sizeof(int),CHUNKSIZE,outfile);
      r = r->Next;
    }
}

/************************************************************************
 * Function Name   :  FreeBuffer()
 * Description     :  Free all the remaining chunks in buffer.
 ***********************************************************************/
 
void FreeBuffer(r)
     replayChunk *r;
{
  if(r->Next)
    FreeBuffer(r->Next);
  XtFree((char *)r);
}

/************************************************************************
 * Function Name   :  Plot_FreeBuffer()
 * Description     :  Free up and re-initialize the plot buffer
 ***********************************************************************/
 
void Plot_FreeBuffer(w)
     Widget w;
{
  PlotWidget pw = (PlotWidget) w;
  FreeBuffer(pw->plot.replayBuffer);
  Plot_InitBuffer(w);
}

/************************************************************************
 * Function Name   : Plot_ToBuffer()
 * Date            : Thu Jun 27 15:10:36 BST 1991
 * Description     : Save data in buffer.
 *                   NB. This assumes that data length < CHUNKSIZE.
 ***********************************************************************/
 
void Plot_ToBuffer( w,OpCode , Length , Data )
     Widget w;
     int OpCode;
     int Length;
     int *Data;
{
  PlotWidget pw = (PlotWidget)w;
  replayChunk *c;
  int *cptr;
  int i;
  int *BufData;

  if(pw->plot.BufferFull)
    return;
  c    = pw->plot.currentChunk;
  cptr = &(pw->plot.chunkPtr);


  if( (*cptr + Length + 4) > CHUNKSIZE)
    { /* Link to next chunk */
      if(pw->plot.NumChunks == pw->plot.MaxChunks)
	{
#ifdef _WIN32
	  printf("*** WARNING graphics replay buffer is full.\n");
	  printf("*** This picture will not redraw completely on resize/expose.\n");
	  printf("*** For a picture this complex you must increase\n");
	  printf("*** the replay buffer size by the command line argument\n");
	  printf("*** \"-mc <N>\" where N a number of 2 kilobyte chunks.\n");
	  printf("*** The current value of N is %d\n",pw->plot.MaxChunks);
#else
	  fprintf(stderr,"*** WARNING graphics replay buffer is full.\n");
	  fprintf(stderr,"*** This picture will not redraw completely on resize/expose.\n");
	  fprintf(stderr,"*** For a picture this complex you must increase\n");
	  fprintf(stderr,"*** the replay buffer size by the command line argument\n");
	  fprintf(stderr,"*** \"-mc <N>\" where N a number of 2 kilobyte chunks.\n");
	  fprintf(stderr,"*** The current value of N is %d\n",pw->plot.MaxChunks);
#endif
	  pw->plot.BufferFull = 1;
	}
      else
	{
	  pw->plot.NumChunks++;
	  c->data[*cptr] = RPB_LINK;
	  c->Next        = XtNew(replayChunk);
	  c              = c->Next;
	  c->Next        = NULL;

	  pw->plot.currentChunk = c;
	  *cptr = 0;
	}
    }
  
  c->data[*cptr   ] = OpCode;
  c->data[*cptr +1] = Length;
  *cptr += 2;
  BufData = c->data + *cptr;
  for(i=0;i<Length;i++)
    *BufData++ = *Data++;
  *cptr += Length;
  c->data[*cptr] = RPB_END;
}

      
/************************************************************************
 * Function Name   : Plot_FromBuffer()
 * Description     : Retrieve data from buffer.
 *                   NB. This assumes that data length < CHUNKSIZE.
 *                   A later version will implement continuation.
 *                   It is assumed that the buffer for the data is
 *                   large enough to hold 1 chunk.  
 ***********************************************************************/

int Plot_FromBuffer( w,OpCode , Length , Data )
     Widget w;
     int* OpCode;
     int* Length;
     int* Data;
{
  PlotWidget pw = (PlotWidget)w;
  replayChunk *c;
  int *cptr;
  int i;
  int *BufData;

  c    = pw->plot.currentChunk;
  cptr = &(pw->plot.chunkPtr);

  *OpCode = c->data[*cptr];
  if(*OpCode == RPB_END)
    return(0);
  if(*OpCode == RPB_LINK)
    { /* Link to next chunk */
      c = c->Next;
      pw->plot.currentChunk = c;
      *OpCode = c->data[0];
      *cptr=0;
    }
  (*cptr)++;
  *Length = c->data[*cptr];
  (*cptr)++ ; 
  BufData = c->data + *cptr;
  for(i=0;i<*Length;i++)
    *Data++ = *BufData++;
  *cptr += *Length;
  return(1);
}
