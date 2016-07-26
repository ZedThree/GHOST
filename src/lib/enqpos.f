      SUBROUTINE ENQPOS(RPARAM)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 256)   VERSION (A7.3)    11:FEB:85
C          ------------------------------------------------
C
C          THIS RETURNS THE CURRENT PLOTTING POSITION.
C
C
      REAL RPARAM(2)
C
C
      COMMON /T0PPOS/ XPLOT0,YPLOT0
C
C
      RPARAM(1)= XPLOT0
      RPARAM(2)= YPLOT0
C
      RETURN
      END
