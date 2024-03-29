      SUBROUTINE ENQINF(IPARAM,CPARAM)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 261)   VERSION (A8.5)    17:JUN:86
C                         === FORTRAN-77 ===
C          ------------------------------------------------
C
C          THIS RETURNS CURRENT FILE AND PICTURE INFORMATION.
C
C
      INTEGER   IPARAM(2)
      CHARACTER CPARAM(2)*(*)
C
      COMMON /T2INFI/ INFOFI(32),INFOPI(32)
      COMMON /T2INLI/ LNFOFI,LNFOPI
      COMMON /T3MACH/ NMCHI,NBITMC
C
C
      IPARAM(1)= LNFOFI
      IPARAM(2)= LNFOPI
      LENCP= LEN(CPARAM(1))
      IF (LENCP.GT.128) LENCP= 128
C
      DO 100 MOVE= 1,LENCP
        CALL G4GETK(INFOFI,MOVE,NBITMC,NMCHI,ICHAR)
        CPARAM(1)(MOVE:MOVE)= CHAR(ICHAR)
        CALL G4GETK(INFOPI,MOVE,NBITMC,NMCHI,ICHAR)
        CPARAM(2)(MOVE:MOVE)= CHAR(ICHAR)
  100 CONTINUE
C
      RETURN
      END
