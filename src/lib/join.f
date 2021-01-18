      SUBROUTINE JOIN(X,Y)
C
C          ------------------------------------------------
C          ROUTINE NO. (  73)   VERSION (A8.5)    24:NOV:86
C          ------------------------------------------------
C
C          THIS DRAWS A LINE FROM THE CURRENT POSITION TO (X,Y).
C
C
      REAL    RDATA(2)
      INTEGER IDATA(1)
C
      COMMON /T0PPOS/ XPLOT0,YPLOT0
      COMMON /T3LIMS/ IMAXI,RMAXI,RMINI
      COMMON /T3NBYR/ NBYTR
C
      DATA IDATA /0/
C
C
      IF (ABS(X-XPLOT0).LT.RMINI.AND.
     &    ABS(Y-YPLOT0).LT.RMINI) RETURN
C
      RDATA(1)= X
      RDATA(2)= Y
      CALL G3LINK(0,3,2*NBYTR,IDATA,RDATA)
      XPLOT0= X
      YPLOT0= Y
C
      RETURN
      END
