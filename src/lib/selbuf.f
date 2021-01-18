      SUBROUTINE SELBUF(NBUFFR)
C
C          ------------------------------------------------
C          ROUTINE NO. (  12)   VERSION (A7.4)    11:FEB:85
C          ------------------------------------------------
C
C          THIS SELECTS BUFFER NO. 'NBUFFR'.
C
C
      REAL    RDATA(1)
      INTEGER IDATA(1)
      LOGICAL ERRON
C
      COMMON /T0BUFN/ KBUFR0
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
      COMMON /T3ERRS/ ERRON,NUMERR
C
      DATA RDATA /0.0/
C
C
      CALL G3INIT(2)
C
      ITRAC1= NBUFFR
      IF (IPRINT.EQ.1) CALL G0MESG(114,5)
      IF (NBUFFR.LE.0.OR.NBUFFR.GT.16) GO TO 901
C
      KBUFR0= NBUFFR
      IDATA(1)= NBUFFR
      CALL G3LINK(4,1,-1,IDATA,RDATA)
      RETURN
C
  901 NUMERR= 6
      IF (ERRON) CALL G0ERMS
      RETURN
      END
