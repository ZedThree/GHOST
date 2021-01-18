      SUBROUTINE DEFPEN
C
C          ------------------------------------------------
C          ROUTINE NO. (  70)   VERSION (A7.1)    11:FEB:85
C          ------------------------------------------------
C
C          THIS SETS THE PEN COLOUR TO ITS DEFAULT VALUE.
C
C
      REAL    RDATA(1)
      INTEGER IDATA(1)
C
      COMMON /T0LATT/ KOLIN0,ITHIK0
      COMMON /T0TRAC/ IPRINT
C
      DATA RDATA /0.0/, IDATA /0/
C
C
      CALL G3INIT(2)
C
      IF (IPRINT.EQ.1) CALL G0MESG(139,0)
C
      KOLIN0= 0
      CALL G3LINK(3,9,-1,IDATA,RDATA)
C
      RETURN
      END
