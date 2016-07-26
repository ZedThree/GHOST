#include <time.h>
#include <stdio.h>

#if defined _WIN32
#  define ENQTIM ENQTIM
#  define STDCALL __stdcall
#elif defined USEUNDERSCORE
#  define ENQTIM enqtim_
#  define STDCALL
#else
#  define ENQTIM enqtim
#  define STDCALL
#endif

void STDCALL ENQTIM(char* chtime, int len)
{
  int i;
  long clock;
  char *timchr;

  clock= time(NULL);
  timchr= ctime(&clock);

  for (i= 0;i<= 7;i++)
    chtime[i]= *(timchr+i+11);
  return;
}
