      SUBROUTINE LINCOL(NCOLOR)
C
C          ------------------------------------------------
C          ROUTINE NO. (  61)   VERSION (A7.1)    11:FEB:85
C          ------------------------------------------------
C
C          THIS SETS THE CURRENT LINE COLOUR.
C
C
C          THE ARGUMENT IS AS FOLLOWS:
C
C          <NCOLOR> IS THE REQUIRED COLOUR NUMBER.
C
C
      REAL    RDATA(1)
      INTEGER IDATA(1)
C
      COMMON /T0LATT/ KOLIN0,ITHIK0
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
C
      DATA RDATA /0.0/
C
C
      CALL G3INIT(2)
C
      ITRAC1= NCOLOR
      IF (IPRINT.EQ.1) CALL G0MESG(138,5)
C
      IF (NCOLOR.LT.0.OR.NCOLOR.GT.255) RETURN
      KOLIN0= NCOLOR
      IDATA(1)= KOLIN0
      CALL G3LINK(3,9,-1,IDATA,RDATA)
C
      RETURN
      END
