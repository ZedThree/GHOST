      SUBROUTINE POSITN(X,Y)
C
C          ------------------------------------------------
C          ROUTINE NO. (  71)   VERSION (A7.4)    11:FEB:85
C          ------------------------------------------------
C
C          THIS MOVES THE PEN TO (X,Y) WITHOUT DRAWING.
C
C
      REAL    RDATA(2)
      INTEGER IDATA(1)
C
      COMMON /T0PPOS/ XPLOT0,YPLOT0
      COMMON /T3NBYR/ NBYTR
C
      DATA IDATA /0/
C
C
      RDATA(1)= X
      RDATA(2)= Y
      CALL G3LINK(0,2,2*NBYTR,IDATA,RDATA)
C
      XPLOT0= X
      YPLOT0= Y
      RETURN
      END
