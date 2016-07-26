#if defined USEUNDERSCORE
#  define G4GETC g4getc_
#  define STDCALL
#elif defined _WIN32
#  define STDCALL __stdcall
#else
#  define G4GETC g4getc
#  define STDCALL
#endif

void STDCALL G4GETC(char array[], int* iplace, int* nbitsc, int* nchrpw, int* nchar)
{
  *nchar= array[*iplace-1]&255;
  return;
}
