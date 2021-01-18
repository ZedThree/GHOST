      SUBROUTINE GRAD
C
C          ------------------------------------------------
C          ROUTINE NO. (  36)   VERSION (A7.4)    11:FEB:85
C          ------------------------------------------------
C
C          THIS SETS THE CURRENT ANGLE TYPE TO GRADS.
C
C
      COMMON /T0ACON/ ANGCON
      COMMON /T0TRAC/ IPRINT
      COMMON /T3CONS/ PI
C
C
      CALL G3INIT(2)
C
      IF (IPRINT.EQ.1) CALL G0MESG(20,0)
C
      ANGCON= 0.005*PI
      RETURN
      END
