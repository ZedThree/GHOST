      SUBROUTINE HATSFT(ISHIFT,IENABL)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 336)   VERSION (A8.1)    12:OCT:95
C          ------------------------------------------------
C
C          THIS SETS THE DISTANCE FROM THE POINT (0,0)
C          THAT THE CONTROL LINE PASSES THROUGH.
C
C
C          THE ARGUMENTS ARE AS FOLLOWS:
C
C          <ISHIFT>, THE SHIFT TO BE SET,
C          <IENABL>, CONTROLS WHICH PARAMETERS ARE SET:
C                =1, TO APPLY TO THE FIRST SET OF LINES,
C                =2, TO APPLY TO THE SECOND SET OF LINES,
C                =3, TO APPLY TO BOTH SETS OF LINES.
C
C
      REAL    RDATA(1)
      INTEGER IDATA(2)
C
      COMMON /T0HFLG/ NHFLG0(255)
      COMMON /T0HNUM/ IHATN0
      COMMON /T0HOFF/ ISHFT0(255,2)
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
C
      DATA RDATA /0.0/
C
C
      CALL G3INIT(2)
      ITRAC1= ISHIFT
      IF (IPRINT.EQ.1) CALL G0MESG(183,5)
      IF (IENABL.EQ.0) RETURN
C
      ISHFT= ISHIFT
      IF (ISHFT.GT.255) ISHFT= 255
      IF (ISHFT.LT.0) RETURN
C
      IENAB= IENABL
      IF (IENAB.LT.1.OR.IENAB.GT.3) IENAB= 3
      IF (MOD(IENAB,2).EQ.1) ISHFT0(IHATN0,1)= ISHFT
      IF (IENAB/2.EQ.1)      ISHFT0(IHATN0,2)= ISHFT
C
      NHFLG0(IHATN0)= 1
C
      IDATA(1)= ISHFT
      IDATA(2)= IENAB
      CALL G3LINK(5,7,-2,IDATA,RDATA)
C
      RETURN
      END
