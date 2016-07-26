      SUBROUTINE LINE(DX,DY)
C
C          ------------------------------------------------
C          ROUTINE NO. (  76)   VERSION (A8.4)    24:NOV:86
C          ------------------------------------------------
C
C          THIS DRAWS AN INCREMENTAL LINE OF LENGTH (DX,DY).
C
C
      COMMON /T0PPOS/ XPLOT0,YPLOT0
      COMMON /T3LIMS/ IMAXI,RMAXI,RMINI
C
C
      IF (ABS(DX).LT.RMINI.AND.ABS(DY).LT.RMINI) RETURN
C
      X= XPLOT0+DX
      Y= YPLOT0+DY
      CALL JOIN(X,Y)
C
      RETURN
      END
