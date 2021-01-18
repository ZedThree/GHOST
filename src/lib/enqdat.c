#include <time.h>
#include <stdio.h>

#if defined _WIN32
#  define ENQDAT ENQDAT
#  define STDCALL __stdcall
#elif defined USEUNDERSCORE
#  define ENQDAT enqdat_
#  define STDCALL
#else
#  define ENQDAT enqdat
#  define STDCALL
#endif

void STDCALL ENQDAT(char* chdate, int len)
{
  long clock;
  char *timchr;

  clock= time(NULL);
  timchr= ctime(&clock);

  chdate[0]= timchr[8];
  chdate[1]= timchr[9];
  chdate[2]= '/';
  chdate[3]= timchr[4];
  chdate[4]= timchr[5]-32;
  chdate[5]= timchr[6]-32;
  chdate[6]= '/';
  chdate[7]= timchr[22];
  chdate[8]= timchr[23];
  return;
}
