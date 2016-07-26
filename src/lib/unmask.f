      SUBROUTINE UNMASK(LEVEL)
C
C          ------------------------------------------------
C          ROUTINE NO. (  29)   VERSION (A7.5)    11:FEB:85
C          ------------------------------------------------
C
C          THIS SETS THE CURRENT LEVEL OF MASKING.
C
C
      REAL    RDATA(1)
      INTEGER IDATA(1)
      LOGICAL ERRON
C
      COMMON /T0MASK/ X1MSK0(10),X2MSK0(10),Y1MSK0(10),Y2MSK0(10),MSKLV0
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
C
      COMMON /T3ERRS/ ERRON,NUMERR
C
      DATA RDATA /0.0/
C
C
      ITRAC1= LEVEL
      IF (IPRINT.EQ.1) CALL G0MESG(14,5)
C
      IF (LEVEL.LT.0.OR.LEVEL.GT.10) GO TO 901
C
      IDATA(1)= LEVEL
      CALL G3LINK(7,7,-1,IDATA,RDATA)
      MSKLV0= LEVEL
      RETURN
C
  901 NUMERR= 4
      IF (ERRON) CALL G0ERMS
      RETURN
      END