      SUBROUTINE CTROBL(OBLAT)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 176)   VERSION (A7.4)    11:FEB:85
C          ------------------------------------------------
C
C          THIS SETS THE WIDTH OF A CHAR. RELATIVE TO ITS HEIGHT.
C
C
      REAL    RDATA(1)
      INTEGER IDATA(1)
C
      COMMON /T0CDIM/ MAGN0,OBLAT0
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAR/ RTRAC1,RTRAC2,RTRAC3,RTRAC4
      COMMON /T3NBYR/ NBYTR
C
      DATA IDATA /0/
C
C
      CALL G3INIT(2)
C
      RTRAC1= OBLAT
      IF (IPRINT.EQ.1) CALL G0MESG(112,1)
C
      OBLAT0= ABS(OBLAT)
      RDATA(1)= OBLAT0
      CALL G3LINK(2,8,NBYTR,IDATA,RDATA)
C
      RETURN
      END
