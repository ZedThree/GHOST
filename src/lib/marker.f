      SUBROUTINE MARKER(ICHAR)
C
C          ------------------------------------------------
C          ROUTINE NO. (  84)   VERSION (A7.4)    11:FEB:85
C          ------------------------------------------------
C
C          THIS SETS THE POLYMARKER CHARACTER.
C
C
      REAL    RDATA(1)
      INTEGER IDATA(1)
      LOGICAL ERRON
C
      COMMON /T0MRKS/ MARKC0
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
C
      COMMON /T3ERRS/ ERRON,NUMERR
C
      DATA RDATA /0.0/
C
C
      CALL G3INIT(2)
C
      ITRAC1= ICHAR
      IF (IPRINT.EQ.1) CALL G0MESG(120,5)
C
      IF (ICHAR.LT.0.OR.ICHAR.GT.255) GO TO 901
      MARKC0= ICHAR
      IDATA(1)= ICHAR
      CALL G3LINK(2,9,-1,IDATA,RDATA)
      RETURN
C
  901 NUMERR= 33
      IF (ERRON) CALL G0ERMS
      RETURN
      END
