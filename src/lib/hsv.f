      SUBROUTINE HSV
C
C          ------------------------------------------------
C          ROUTINE NO. (  66)   VERSION (A7.1)    11:FEB:85
C          ------------------------------------------------
C
C          THIS SELECTS THE <HSI> COLOUR SYSTEM. COLOUR
C          PARAMETERS ARE NOW <HUE, SATURATION, VALUE>.
C
C
      COMMON /T0KSYS/ KOLSYS
      COMMON /T0TRAC/ IPRINT
C
C
      CALL G3INIT(2)
      IF (IPRINT.EQ.1) CALL G0MESG(131,0)
C
      KOLSYS= 1
C
      RETURN
      END
