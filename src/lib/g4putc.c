#if defined USEUNDERSCORE
#  define G4PUTC g4putc_
#  define STDCALL
#elif defined _WIN32
#  define STDCALL __stdcall
#else
#  define G4PUTC g4putc
#  define STDCALL
#endif

void STDCALL G4PUTC(char array[], int* iplace, int* nbitsc, int* nchrpw, int* nchar)
{
  array[*iplace-1]= *nchar;
  return;
}
