      SUBROUTINE CTRMAG(MAG)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 142)   VERSION (A7.4)    11:FEB:85
C          ------------------------------------------------
C
C          THIS SETS THE CURRENT CHARACTER SIZE IN PLOTTER UNITS.
C
C
      REAL    RDATA(1)
      INTEGER IDATA(1)
C
      COMMON /T0CDIM/ MAGN0,OBLAT0
      COMMON /T0CSIZ/ CSIZE,MRKSIZ
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
C
      DATA RDATA /0.0/
C
C
      CALL G3INIT(2)
C
      ITRAC1= MAG
      IF (IPRINT.EQ.1) CALL G0MESG(53,5)
C
      MAGN0= MAG
      IF (MAGN0.LT.1) MAGN0= 1
      IF (MAGN0.GT.255) MAGN0= 255
      MRKSIZ= 0
      IDATA(1)= MAGN0
      CALL G3LINK(2,3,-1,IDATA,RDATA)
C
      RETURN
      END
