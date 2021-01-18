      SUBROUTINE HLS
C
C          ------------------------------------------------
C          ROUTINE NO. (  64)   VERSION (A7.1)    11:FEB:85
C          ------------------------------------------------
C
C          THIS SELECTS THE <HSV> COLOUR SYSTEM. COLOUR
C          PARAMETERS ARE NOW <HUE, LIGHTNESS, SATURATION>.
C
C
      COMMON /T0KSYS/ KOLSYS
      COMMON /T0TRAC/ IPRINT
C
C
      CALL G3INIT(2)
      IF (IPRINT.EQ.1) CALL G0MESG(130,0)
C
      KOLSYS= 2
C
      RETURN
      END
