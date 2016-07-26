      SUBROUTINE CURVEM(METHOD)
C
C          ------------------------------------------------
C          ROUTINE NO. (  93)   VERSION (A7.4)    11:FEB:85
C          ------------------------------------------------
C
C          THIS SETS THE CURVE DRAWING METHOD WHICH IS USED.
C
C
C          <METHOD> = 1 FOR A ROTATIONALLY INVARIANT CURVE.
C                   = 2 FOR A SINGLE VALUED CURVE
C                       FROM SINGLE VALUED DATA.
C
C
      LOGICAL ERRON
C
      COMMON /T0CURV/ MCURV0
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
      COMMON /T3ERRS/ ERRON,NUMERR
C
C
      CALL G3INIT(2)
C
      ITRAC1= METHOD
      IF (IPRINT.EQ.1) CALL G0MESG(36,5)
C
      IF (METHOD.LT.1.OR.METHOD.GT.2) GO TO 901
C
      MCURV0= METHOD
      RETURN
C
  901 NUMERR= 10
      IF (ERRON) CALL G0ERMS
C
      RETURN
      END
