#if defined _WIN32
#  define G4GETB G4GETB
#  define STDCALL __stdcall
#elif defined USEUNDERSCORE
#  define G4GETB g4getb_
#  define STDCALL
#else
#  define G4GETB g4getb
#  define STDCALL

#endif

#if !defined(LITTLE_ENDIAN)

void STDCALL G4GETB( unsigned *iword, unsigned *iposn, unsigned *ibit)
{
  *ibit= (*iword>>(32-*iposn))&1;
  return;
}

#else

static int swap[] = {
   7,6,5,4,3,2,1,0,15,14,13,12,11,10,9,8,
   23,22,21,20,19,18,17,16,31,30,29,28,27,26,25,24
};

void STDCALL G4GETB( unsigned *iword, unsigned *iposn, unsigned *ibit)
{
  *ibit= (*iword>>swap[*iposn-1])&1;
  return;
}

#endif
