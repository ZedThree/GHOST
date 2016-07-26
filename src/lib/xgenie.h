/************************************************************************
 * Application: xgenie
 * File       : xgenie.h
 * Author     : I.G.D.Strachan
 * Date       : 4/3/92
 * Version    : 1.1
 * Description: Header file for xgenie interface file
 *
 *
 * Status     : Released
 * QA check   : 
 * QA date    :
 ***********************************************************************/

/****************  INCLUDES             ********************************/
#include "Opcodes.h"
/****************  COMPILER DIRECTIVES  ********************************/
/****************  TYPE DEFINITIONS     ********************************/
/****************  MACROS               ********************************/

#ifdef USEUNDERSCORE
#  define IARGC  iargc_
#  define GETARG getarg_
#  define XINIT  xinit_
#  define XPOLYL xpolyl_
#  define XPOLYM xpolym_
#  define XTEXT  xtext_
#  define XSTRNG xstrng_
#  define XCHARH xcharh_
#  define XCHARO xcharo_
#  define XCHARB xcharb_
#  define XLINET xlinet_
#  define XFILLP xfillp_
#  define XCOLTB xcoltb_
#  define XSETFC xsetfc_
#  define XGETIN xgetin_
#  define XCLRWN xclrwn_
#  define XWNDIM xwndim_
#  define XCLOSE xclose_
#  define XFLSBF xflsbf_
#  define XDEFIM xdefim_
#  define XPUTIM xputim_
#  define XDUMPB xdumpb_
#  define STDCALL
#elif defined _WIN32
#  define STDCALL __stdcall
#else
#  define IARGC  iargc
#  define GETARG getarg
#  define XINIT  xinit
#  define XPOLYL xpolyl
#  define XPOLYM xpolym
#  define XTEXT  xtext
#  define XSTRNG xstrng
#  define XCHARH xcharh
#  define XCHARO xcharo
#  define XCHARB xcharb
#  define XLINET xlinet
#  define XFILLP xfillp
#  define XCOLTB xcoltb
#  define XSETFC xsetfc
#  define XGETIN xgetin
#  define XCLRWN xclrwn
#  define XWNDIM xwndim
#  define XCLOSE xclose
#  define XFLSBF xflsbf
#  define XDEFIM xdefim
#  define XPUTIM xputim
#  define XDUMPB xdumpb
#  define STDCALL
#endif
/****************  GLOBAL VARIABLES     ********************************/
/****************  STATIC VARIABLES     ********************************/
static char xgenie_hSID[] = "@(#)xgenie.h	1.3 CULHAM 08/09/01";
/****************  FUNCTION PROTOTYPES  ********************************/
/****************  FUNCTIONS            ********************************/
