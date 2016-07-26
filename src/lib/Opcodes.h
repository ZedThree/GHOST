/************************************************************************
 * Application: xgenie
 * File       : Opcodes.h
 * Author     : I.G.D.Strachan
 * Date       : 4/3/92
 * Version    : 1.2
 * Description: Opcodes for data transfer between xgenie 
 *              and graphics client  
 *
 *
 * Status     : Released
 * QA check   : 
 * QA date    :
 ***********************************************************************/

/****************  INCLUDES             ********************************/
/****************  COMPILER DIRECTIVES  ********************************/
/****************  TYPE DEFINITIONS     ********************************/
/****************  MACROS               ********************************/
#define OP_POLYLINE   0x2001
#define OP_POLYMARK   0x2002
#define OP_FILLPOLY   0x2003
#define OP_TEXT       0x2004
#define OP_SETFC      0x2005
#define OP_FLUSH      0x2006
#define OP_GETIN      0x2007
#define OP_COLTB      0x2008
#define OP_ERASE      0x2009
#define OP_DEFIMAGE   0x200a
#define OP_PUTIMAGE   0x200b
#define OP_DUMPBUFFER 0x200c
#define OP_QUIT       -1
/****************  GLOBAL VARIABLES     ********************************/
/****************  STATIC VARIABLES     ********************************/
static char Opcodes_hSID[] = "4/3/92 @(#)Opcodes.h	1.2";
/****************  FUNCTION PROTOTYPES  ********************************/
/****************  FUNCTIONS            ********************************/



