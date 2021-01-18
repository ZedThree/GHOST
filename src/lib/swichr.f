      SUBROUTINE SWICHR(KOMCHR,NUMCHR)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 182)   VERSION (A7.2)    11:FEB:85
C          ------------------------------------------------
C
C          THIS DEFINES THE COMMAND-STRING SWITCH (<KOMCHR>) AND
C          CHARACTER-NUMBER IDENTIFIER (<NUMCHR>) CHARACTERS. IF
C          THE GIVEN VALUE IS < 0, THE OLD VALUE IS NOT CHANGED.
C
C
      COMMON /T0COMS/ NOWCOM,NOWNUM
C
C
      IF (KOMCHR.GT.0) NOWCOM= KOMCHR
      IF (NUMCHR.GT.0) NOWNUM= NUMCHR
C
      RETURN
      END
