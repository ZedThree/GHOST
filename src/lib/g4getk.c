#if defined USEUNDERSCORE
#  define G4GETK g4getk_
#  define STDCALL
#elif defined _WIN32
#  define STDCALL __stdcall
#else
#  define G4GETK g4getk
#  define STDCALL
#endif

void STDCALL G4GETK(char iarray[], int* iplace, int* nbitsc, int* nchrpw, int* nchar)
{
  *nchar= iarray[*iplace-1]&255;
  return;
}
