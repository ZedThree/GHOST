      SUBROUTINE UNLBUF(NBUFFR)
C
C          ------------------------------------------------
C          ROUTINE NO. (  14)   VERSION (A7.4)    11:FEB:85
C          ------------------------------------------------
C
C          THIS UNLOADS BUFFER NO. 'NBUFFR'.
C
C
      REAL    RDATA(1)
      INTEGER IDATA(1)
      LOGICAL ERRON
C
      COMMON /T0BUFN/ KBUFR0
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
C
      COMMON /T3ERRS/ ERRON,NUMERR
C
      DATA RDATA /0.0/
C
C
      ITRAC1= NBUFFR
      IF (IPRINT.EQ.1) CALL G0MESG(116,5)
C
      IF (NBUFFR.LE.0.OR.NBUFFR.GT.16) GO TO 901
C
      KBUFR0= NBUFFR
      IDATA(1)= NBUFFR
      CALL G3LINK(4,3,-1,IDATA,RDATA)
      RETURN
C
  901 NUMERR= 7
      IF (ERRON) CALL G0ERMS
      RETURN
      END
