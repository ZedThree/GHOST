#if defined USEUNDERSCORE
#  define G4PUTK g4putk_
#  define STDCALL
#elif defined _WIN32
#  define STDCALL __stdcall
#else
#  define G4PUTK g4putk
#  define STDCALL
#endif

void STDCALL G4PUTK(char iarray[], int* iplace, int* nbitsc, int* nchrpw, int* nchar)
{
  iarray[*iplace-1]= *nchar;
  return;
}
