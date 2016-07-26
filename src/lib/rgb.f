      SUBROUTINE RGB
C
C          ------------------------------------------------
C          ROUTINE NO. (  63)   VERSION (A7.1)    11:FEB:85
C          ------------------------------------------------
C
C          THIS SELECTS THE <RGB> COLOUR SYSTEM, AND
C          COLOUR PARAMETERS ARE NOW <RED, GREEN, BLUE>.
C
C
      COMMON /T0KSYS/ KOLSYS
      COMMON /T0TRAC/ IPRINT
C
C
      CALL G3INIT(2)
      IF (IPRINT.EQ.1) CALL G0MESG(129,0)
C
      KOLSYS= 4
C
      RETURN
      END
