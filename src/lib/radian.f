      SUBROUTINE RADIAN
C
C          ------------------------------------------------
C          ROUTINE NO. (  34)   VERSION (A7.4)    11:FEB:85
C          ------------------------------------------------
C
C          THIS SETS THE CURRENT ANGLE TYPE TO RADIANS.
C
C
      COMMON /T0ACON/ ANGCON
      COMMON /T0TRAC/ IPRINT
C
C
      CALL G3INIT(2)
C
      IF (IPRINT.EQ.1) CALL G0MESG(18,0)
C
      ANGCON= 1.0
      RETURN
      END
