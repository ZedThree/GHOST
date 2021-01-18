#ifdef USEUNDERSCORE
#  define G4PUTB g4putb_
#  define STDCALL
#elif defined _WIN32
#  define G4PUTB G4PUTB
#  define STDCALL __stdcall
#else
#  define G4PUTB g4putb
#  define STDCALL
#endif

#if !defined(LITTLE_ENDIAN)

void STDCALL G4PUTB( unsigned *iword, unsigned *iposn, unsigned *ibit)
{
    if (*iposn!=1)
	*iword= (((~0<<(33-*iposn))|((1<<(32-*iposn))-1))&*iword)|(*ibit<<(32-*iposn));
    else
	*iword= (((1<<(32-*iposn))-1)&*iword)|(*ibit<<(32-*iposn));
    return;
}

#else

static int swap[32] = {
    7,6,5,4,3,2,1,0,15,14,13,12,11,10,9,8,
    23,22,21,20,19,18,17,16,31,30,29,28,27,26,25,24
};
void STDCALL G4PUTB( unsigned *iword, unsigned *iposn, unsigned *ibit)
{
    int itmp;
    itmp = 1<<(swap[*iposn-1]);
    if ( *ibit == 0 )
	*iword = ~itmp & *iword;
    else
	*iword = itmp | *iword;
    return;
}

#endif
