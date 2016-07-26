      SUBROUTINE DEGREE
C
C          ------------------------------------------------
C          ROUTINE NO. (  35)   VERSION (A7.4)    11:FEB:85
C          ------------------------------------------------
C
C          THIS SETS THE CURRENT ANGLE TYPE TO DEGREES.
C
C
      COMMON /T0ACON/ ANGCON
      COMMON /T0TRAC/ IPRINT
      COMMON /T3CONS/ PI
C
C
      CALL G3INIT(2)
C
      IF (IPRINT.EQ.1) CALL G0MESG(19,0)
C
      ANGCON= PI/180.0
      RETURN
      END
