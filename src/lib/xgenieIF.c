/************************************************************************
 * Application: xgenie
 * File       : xgenieIF.c
 * Author     : I.G.D.Strachan
 * Date       : 11/7/91
 * Version    : 1.1.1.2
 * Description: Interface library for the xgenie program
 *              This library is designed to be FORTRAN callable, so all
 *              the arguments are pointers. Procedure names are actually
 *              #define macros which are set according to the convention
 *              of the machine.
 *
 *              All graphics coordinates are assumed to be in the range
 *              0 -> 32767.
 *
 *
 * Status     : Released
 * QA check   : 
 * QA date    :
 ***********************************************************************/

/****************  INCLUDES             ********************************/
#include "xgenie.h"
#ifdef _WIN32
#  include <process.h>
#  include <io.h>
#  include <fcntl.h>
#  define pipe(x) _pipe(x,0,_O_BINARY|_O_NOINHERIT)
#  include "ghostkeys.h"
#else
#  include <unistd.h>
#endif
#include <errno.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
/****************  COMPILER DIRECTIVES  ********************************/
/****************  TYPE DEFINITIONS     ********************************/
/****************  MACROS               ********************************/
/****************  GLOBAL VARIABLES     ********************************/
/* extern int errno; */
FILE *OutPipe,*InPipe;
int argc;
char **argv;
char GeomString[30];
/****************  STATIC VARIABLES     ********************************/
static char xgenieIF_cSID[] = "@(#)xgenieIF.c	1.1.1.2 11/7/91";
static char ServerPath[256];
/****************  FUNCTION DECLARATIONS********************************/
void STDCALL XINIT();
int STDCALL IARGC();
#ifdef _WIN32
void STDCALL GETARG(int*,char*,int,int*);
#else
void STDCALL GETARG(int*,char*,int);
#endif
int  GetArgCount();
void GetArg(int*, char*, int);
void STDCALL XPOLYL(int* xpoints, int* ypoints, int* numpoints);
void STDCALL XPOLYM(int* xpoints, int* ypoints, int* numpoints);
void STDCALL XFILLP(int* xpoints, int* ypoints, int* numpoints);
void STDCALL XTEXT(int* xpoint , int* ypoint, unsigned int* character);
void STDCALL XFLSBF();
void STDCALL XCLOSE();
void STDCALL XCOLTB(int* kolnum,int* iredin,int* igrnin,int* ibluin);
void STDCALL XSETFC(int* colour);
void STDCALL XGETIN(int* xp, int* yp, unsigned int *character);
void STDCALL XCLRWN();
void ProcessArgs();
void STDCALL XCHARH(int* height);
void STDCALL XCHARO(int* a, int* b, int* c, int* d);
void STDCALL XCHARB(int* oblate);
void STDCALL XLINET(int* type);
void STDCALL XDEFIM(int* id, int* x1, int* y1, int* x2, int* y2,
		    int* w, int* h, int* scol, int* ecol, char* data);
void STDCALL XPUTIM(int* id);

/****************  FUNCTIONS            ********************************/

/************************************************************************
 * Function Name   :  XINIT
 * Description     :  Initialize the xgenie program by fork/exec.
 *
 *                    This routine forks the xgenie process, and 
 *                    connects streams to it for high level file I/O
 *                    by means of pipes. These are set up as follows.
 *
 *                    The system call pipe() returns an array of 2
 *                    integers, which contain the file descriptors
 *                    of each end of the pipe. Element 0 is the read
 *                    descriptor and element 1 is the write descriptor
 *                    In this routine, they are placed in the variables
 *
 *                    inPipe[0]  - Parent reads  data from child
 *                    inPipe[1]  - Child  writes data to   parent
 *                    outPipe[0] - Child  reads  data from parent
 *                    outPipe[1] - Parent writes data to   child.
 *
 *                    Parent and child close the unwanted descriptors
 *                    after the fork. (Parent closes inPipe[1] and 
 *                    outPipe[0], and child closes inPipe[0] and
 *                    outPipe[1]).
 *
 *                    In the child process, the descriptors are reconnected
 *                    to stdin and stdout ( file descriptors 0 and 1).
 *                    This is achieved by:-
 *                         close(0);
 *                         dup(outPipe[0]);
 *                         close(outPipe[0]);
 *
 *                    As the dup copies the descriptor to the lowest unused 
 *                    descriptor, in this case 0 after the close. The dup'ed
 *                    descriptor is then close'd for tidiness. A similar procedure
 *                    Is adopted for stdout (1).
 *
 *                    In the parent process, file streams are associated with the
 *                    pipe descriptors, by means of fdopen(). These streams
 *                    are called InPipe, and OutPipe (note the capital at the
 *                    beginning distinguishes a stream from a descriptor).
 ***********************************************************************/
 
void STDCALL XINIT(iresx,iresy,idepth)
     int *iresx,*iresy,*idepth;
{
  int inPipe[2],outPipe[2],i;
  char ArgBuf[64];
  char *ArgBufp;
  int pid;
  char *ghost_env;
  char *xgenie_env;

/*
 * 0. Command line argument processing.
 *    have to call the FORTRAN functions IARGC and GETARG
 */

  argc = GetArgCount();

  argv = (char **)calloc(argc+6,sizeof(char *));
  for(i=0;i<=argc;i++)
    {
#ifdef stardent
      struct{char *addr; int len;}STArBuf;
      STArBuf.addr = (char*)malloc(64*sizeof(char));
      STArBuf.len = 64;
      GETARG(&i,&STArBuf);
      strncpy(ArgBuf,STArBuf.addr,STArBuf.len);
#else
      GetArg(&i,ArgBuf,sizeof(ArgBuf));
#endif
      /* Strip off trailing spaces */
      ArgBufp = &(ArgBuf[63]);
      while(ArgBufp[-1] == ' ')
	ArgBufp--;
      ArgBufp[0] = 0;
      argv[i] = (char *)malloc(strlen(ArgBuf)+1);
      strcpy(argv[i],ArgBuf);
    }
  argv[argc+1] = NULL;

/*
 * get GHOST environment variable
 */
  ghost_env = getenv("GHOST");
#ifdef _WIN32
  if ( xgenie_env = getenv("XGENIE") )
      sprintf(ServerPath,"%s\0",xgenie_env);
  else if ( xgenie_env = getXGenie() ) {
      sprintf(ServerPath,"%s\0",getXGenie());
      free(xgenie_env);
  } else 
    sprintf(ServerPath,"%s\0","xgeniex.exe");
#else
  if (xgenie_env = getenv("XGENIE")) {
    sprintf(ServerPath,"%s\0",xgenie_env);
  } else {
    ghost_env = getenv("GHOST");
    if (ghost_env) 
      sprintf(ServerPath,"%s/libexec/xgenie\0",ghost_env);
    else
      sprintf(ServerPath,"%s/xgenie\0",GHOST_LIBEXECDIR);
  }
#endif

  ProcessArgs();

  pipe(inPipe);
  pipe(outPipe);


#ifdef _WIN32
  {
    int hStdIn;
    int hStdOut;
    int Reply;
    /* duplicate old stdin and stdout handles before they get closed*/
    hStdIn  = _dup(_fileno(stdin));
    hStdOut = _dup(_fileno(stdout));
    /*  duplicate pipe connections for child */
    _dup2(inPipe[1], _fileno(stdout));
    _dup2(outPipe[0], _fileno(stdin));
    /* close originals */
    close(inPipe[1]);
    close(outPipe[0]);
    /* spawn process */
    pid = _spawnl(_P_NOWAIT,ServerPath,"xgenie",NULL);
    if ( pid == -1) {
      fprintf(stderr,"Could not exec driver program: %s\n", ServerPath);
      fprintf(stderr,"%s\n",strerror(errno));
      exit(0);
    }      
    /* duplicate original stdin and stdout back */
    _dup2(hStdIn, _fileno(stdin));
    _dup2(hStdOut, _fileno(stdout));
    /* close duplicates */
    close(hStdIn);
    close(hStdOut);
    /* Connect OutPipe stream to outPipe */
    OutPipe = _fdopen(outPipe[1],"wb");
    close(outPipe[0]);
    /* Connect InPipe stream to inPipe   */
    InPipe = _fdopen(inPipe[0],"rb");
    close(inPipe[1]);
    /* Read back params from X program */
    fread(&Reply,1,sizeof(int),InPipe);
    if(Reply == 0)
      {
	fread(iresx,sizeof(int),1,InPipe);
	fread(iresy,sizeof(int),1,InPipe);
	fread(idepth,sizeof(int),1,InPipe);
      }
  }
#else
  if ((pid = fork()) == 0)
    { /* 1. Child process  - do the plumbing */

      /* 1.1. Connect outPipe to stdin */
      close(0);
      dup(outPipe[0]);
      close(outPipe[1]);
      close(outPipe[0]);

      /* 1.2. Connect inPipe to stdout */
      close(1);
      dup(inPipe[1]);
      close(inPipe[0]);
      close(inPipe[1]);

      /* 1.3 Now exec the genie program */
      argv[0] = "xgenie";

      execv(ServerPath,argv);
      
      /* 1.4 Panic if could not exec the program */
      fprintf(stderr,"Could not exec driver program: %s\n", ServerPath);
      fprintf(stderr,"%s\n",strerror(errno));
      exit(0);
    }
  else if (pid > 0) 
    { /* 2. Parent process. Set up InPipe and OutPipe streams to the pipes */
      int Reply;
   
      /* 2.1 Connect OutPipe stream to outPipe */
      OutPipe = fdopen(outPipe[1],"w");
      close(outPipe[0]);

      /* 2.2 Connect InPipe stream to inPipe   */
      InPipe = fdopen(inPipe[0],"r");
      close(inPipe[1]);

      /* 2.3 Read back params from X program */
      fread(&Reply,1,sizeof(int),InPipe);
      if(Reply == 0)
	{
	  fread(iresx,sizeof(int),1,InPipe);
	  fread(iresy,sizeof(int),1,InPipe);
	  fread(idepth,sizeof(int),1,InPipe);
	}
    }
  else 
    { /* fork failed */
      fprintf(stderr,"Could not fork driver program: %s\n", ServerPath);
      fprintf(stderr,"%s\n",strerror(errno)); 
      exit(0);
    }
#endif
}
/************************************************************************
 * Function Name   :  GetArgCount
 * Description     :  Get C style argc from FORTRAN. This glue is 
 *                    required because hp machines define it differently
 ***********************************************************************/
int GetArgCount()
{
#ifdef hp
  return(IARGC()-1);
#else
  return(IARGC());
#endif
}
/************************************************************************
 * Function Name   :  GetArg
 * Description     :  Get C style argv from FORTRAN. This glue is 
 *                    required because hp machines define it differently
 ***********************************************************************/
void GetArg(i,Buffer,len)
     int *i;
     char *Buffer;
     int len;
{
#if hp
  int j = (*i)+1;
  /* HP arg numbers are all incremented by 1 */
  GETARG(&j,Buffer,len);
#elif defined _WIN32
  int status;
  GETARG(i,Buffer,len,&status);
#else
  GETARG(i,Buffer,len);
#endif
}


/************************************************************************
 * Function Name   :  XPOLYL
 * Description     :  Draw PolyLine 
 ***********************************************************************/
 
void STDCALL XPOLYL(int* xpoints, int* ypoints, int* numpoints)
{
  int OpCode;

  OpCode = OP_POLYLINE;
  fwrite(&OpCode,sizeof(int),1,OutPipe);
  fwrite(numpoints,sizeof(int),1,OutPipe);
  fwrite(xpoints,sizeof(int),*numpoints,OutPipe);
  fwrite(ypoints,sizeof(int),*numpoints,OutPipe);
}

/************************************************************************
 * Function Name   :  XPOLYM
 * Description     :  Draw PolyMark 
 ***********************************************************************/
 
void STDCALL XPOLYM(int* xpoints, int* ypoints, int* numpoints)
{
  int OpCode;

  OpCode = OP_POLYMARK;
  fwrite(&OpCode,sizeof(int),1,OutPipe);
  fwrite(numpoints,sizeof(int),1,OutPipe);
  fwrite(xpoints,sizeof(int),*numpoints,OutPipe);
  fwrite(ypoints,sizeof(int),*numpoints,OutPipe);
}

/************************************************************************
 * Function Name   :  XFILLP
 * Description     :  Draw Filled polygon
 ***********************************************************************/
 
void STDCALL XFILLP(int* xpoints, int* ypoints, int* numpoints)
{
  int OpCode;

  OpCode = OP_FILLPOLY;
  fwrite(&OpCode,sizeof(int),1,OutPipe);
  fwrite(numpoints,sizeof(int),1,OutPipe);
  fwrite(xpoints,sizeof(int),*numpoints,OutPipe);
  fwrite(ypoints,sizeof(int),*numpoints,OutPipe);
}

/************************************************************************
 * Function Name   : XTEXT
 * Description     : Put out one Character at specified position
 ***********************************************************************/

void STDCALL XTEXT(int* xpoint , int* ypoint, unsigned int* character)
{
  int OpCode = OP_TEXT;
  char TextBuffer[3];
  sprintf(TextBuffer,"%c\n",*character);
  fwrite(&OpCode,sizeof(int),1,OutPipe);
  fwrite(xpoint,sizeof(int),1,OutPipe);
  fwrite(ypoint,sizeof(int),1,OutPipe);
  fwrite(TextBuffer,sizeof(char),2,OutPipe);
}

/************************************************************************
 * Function Name   :  XFLSBF
 * Description     :  Cause the X buffer to be flushed.
 ***********************************************************************/
 
void STDCALL XFLSBF()
{
  int OpCode;

  OpCode = OP_FLUSH;
  fwrite(&OpCode,sizeof(int),1,OutPipe);
  fflush(OutPipe);
  fread(&OpCode,sizeof(int),1,InPipe);
}


/************************************************************************
 * Function Name   : XCLOSE
 * Description     : Terminate the connection to the xgenie program.
 ***********************************************************************/
 
void STDCALL XCLOSE()
{
  int OpCode;

  OpCode = OP_QUIT;
  fwrite(&OpCode,sizeof(int),1,OutPipe);
  fflush(OutPipe);
  fread(&OpCode,sizeof(int),1,InPipe);
  fclose(InPipe);
  fclose(OutPipe);
}

/************************************************************************
 * Function Name   : XCOLTB
 * Description     : Define entry in colour table
 ***********************************************************************/
 
void STDCALL XCOLTB(int* kolnum,int* iredin,int* igrnin,int* ibluin)
{
  int ColDef[5];

  ColDef[0] = OP_COLTB;
  ColDef[1] = *kolnum;
  ColDef[2] = *iredin;
  ColDef[3] = *igrnin;
  ColDef[4] = *ibluin;
  fwrite(ColDef,sizeof(int),5,OutPipe);
}


/************************************************************************
 * Function Name   :  XSETFC
 * Description     :  Set the foreground colour
 ***********************************************************************/
 
void STDCALL XSETFC(int* colour)
{
  int ColSet[2];

  ColSet[0] = OP_SETFC;
  ColSet[1] = *colour;
  fwrite(ColSet,sizeof(ColSet[0]),2,OutPipe);
}


/************************************************************************
 * Function Name   : XGETIN
 * Description     : Get cursor or keyboard input.
 ***********************************************************************/
 
void STDCALL XGETIN(int* xp, int* yp, unsigned int *character)
{
  int OpCode;
  int Results[5];

  OpCode = OP_GETIN;
  fwrite(&OpCode,sizeof(int),1,OutPipe);
  fflush(OutPipe);
  fread(Results,sizeof(int),5,InPipe);

  *xp = Results[3];
  *yp = Results[4];

  if(Results[0] == 2)
    *character = Results[2];
  else
    switch(Results[1])
      {
      case 1: *character = 'l'; break;
      case 2: *character = 'm'; break;
      case 3: *character = 'r'; break;
      default: *character = 'U'; break;
      }
}

/************************************************************************
 * Function Name   : XCLRWN
 * Description     : Erase the graphics window
 ***********************************************************************/
 
void STDCALL XCLRWN()
{
  int OpCode;

  OpCode = OP_ERASE;
  fwrite(&OpCode,sizeof(int),1,OutPipe);
  fflush(OutPipe);
}
/************************************************************************
 * Function Name   : ProcessArgs
 * Date            : Fri Jul 5 16:18:21 BST 1991
 * Description     : Set up title etc.
 ***********************************************************************/

void ProcessArgs()
{
  char **nargv,**argptr;
  int i;
  int NewName = 0;
  static char *ProgramName;
  static char pname[128];
  ProgramName = argv[0];
  nargv = (char **)malloc((argc+6)*sizeof(char *));
  argptr= nargv;
  for(i=0;i<=argc;i++)
    {
      if(strcmp(argv[i],"-gtit") == 0)
	{
	  ProgramName = argv[++i];
	  NewName = 1;
	}
      else if(strcmp(argv[i],"-s") == 0)
	{
	  sprintf(ServerPath,"%s\0",argv[++i]);
	}
      else
	{
	  *argptr = argv[i];
	  argptr++;
	}
    }

  *argptr++ = "-name";
   sprintf(pname,"%s",ProgramName);

  *argptr = pname;
  argc = argptr - nargv +1;
  for(i=0;i<argc;i++)
    {
      argv[i] = nargv[i];
    }
  argv[argc] = NULL;
  free(nargv);
}

/************************************************************************
 * Function Name   : <Unimplemented dummy routines>
 * Description     : Dummy routines required by GHOST, but 
 *                   unimplementable under X-windows
 ***********************************************************************/

void STDCALL XCHARH(int* height)
{
  return;
}

void STDCALL XCHARO(int* a, int* b, int* c, int* d)
{
    return;
  }
void STDCALL XCHARB(int* oblate)
{
    return;
  }

void STDCALL XLINET(int* type)
{

    return;
  }

/************************************************************************
 * Function Name   : XDEFIM()
 * Description     : Define an image:-
 *                   Identifier  :    id
 *                   Bottom left :    (x1,y1)
 *                   Top right   :    (x2,y2)
 *                   Dimension   :     w X h
 *                   Colours     :    Interpolated on scale between 
 *                                    scol & ecol.
 *                   Pixdata     :    in array data.
 ***********************************************************************/
void STDCALL XDEFIM(int* id, int* x1, int* y1, int* x2, int* y2,
		    int* w, int* h, int* scol, int* ecol, char* data)
{
  int OpCode;
  int Params[9];
  int BytesToWrite,BytesLeft;
  OpCode = OP_DEFIMAGE;
  fwrite(&OpCode,sizeof(int),1,OutPipe);
  Params[0] = *id;
  Params[1] = *x1;
  Params[2] = *y1;
  Params[3] = *x2;
  Params[4] = *y2;
  Params[5] = *w;
  Params[6] = *h;
  Params[7] = *scol;
  Params[8] = *ecol;
  fwrite(Params,sizeof(int),9,OutPipe);
  BytesLeft = (*w)*(*h);
  while(BytesLeft)
    {
      BytesToWrite = BytesLeft > 4096 ? 4096 : BytesLeft;
      fwrite(data,sizeof(char), BytesToWrite, OutPipe);
      fflush(OutPipe);
      fread(&OpCode,sizeof(int),1,InPipe);
      BytesLeft -= BytesToWrite;
      data += BytesToWrite;
    }
}

/************************************************************************
 * Function Name   : XPUTIM()
 * Description     : Actually display the image id
 ***********************************************************************/
void STDCALL XPUTIM(int* id)
{

  int OpCode;
  OpCode = OP_PUTIMAGE;
  fwrite(&OpCode,sizeof(int),1,OutPipe);
  fwrite(id,sizeof(int),1,OutPipe);
}
