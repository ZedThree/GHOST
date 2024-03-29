      SUBROUTINE WINDOW(XAREA1,XAREA2,YAREA1,YAREA2)
C
C          ------------------------------------------------
C          ROUTINE NO. (  26)   VERSION (A8.7)    24:NOV:86
C          ------------------------------------------------
C
C          THIS SETS THE RECTANGLE AVAILABLE FOR PLOTTING.
C
C
C          <XAREA1,YAREA1> IS THE BOTTOM-LEFT AND
C          <XAREA2,YAREA2> IS THE TOP-RIGHT CORNER.
C
C
      REAL    RDATA(4)
      INTEGER IDATA(1)
C
      COMMON /T0AUTM/ MAPNUM
      COMMON /T0MACT/ MRKMAP,MRKWIN
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAR/ RTRAC1,RTRAC2,RTRAC3,RTRAC4
      COMMON /T0WNDO/ X1WND0,X2WND0,Y1WND0,Y2WND0
      COMMON /T3LIMS/ IMAXI,RMAXI,RMINI
      COMMON /T3NBYR/ NBYTR
C
      DATA IDATA /0/
C
C
      CALL G3INIT(2)
      RTRAC1= XAREA1
      RTRAC2= XAREA2
      RTRAC3= YAREA1
      RTRAC4= YAREA2
      IF (IPRINT.EQ.1) CALL G0MESG(11,4)
C
C          THE WINDOW ARGUMENTS ARE SET.
C
      X1WND0= XAREA1
      X2WND0= XAREA2
      Y1WND0= YAREA1
      Y2WND0= YAREA2
C
C          IF NO MAPPING HAS YET BEEN REQUESTED,
C          A LINEAR MAP IS NOW DONE BY DEFAULT.
C
      IF (MRKMAP.NE.0) GO TO 1
C
      MAPNUM= 1
      MRKWIN= -1
      CALL G0MAPS(XAREA1,XAREA2,YAREA1,YAREA2)
      MRKMAP= 0
C
C          THE WINDOW MARKER IS SET.
C          THE ARGUMENTS ARE PASSED ON IF THEY ARE VALID,
C          THEN THE CURRENT PLOTTING POSITION IS RESET.
C
    1 MRKWIN= 1
      IF (ABS(X2WND0-X1WND0).LT.RMINI.OR.
     &    ABS(Y2WND0-Y1WND0).LT.RMINI) RETURN
C
      RDATA(1)= X1WND0
      RDATA(2)= X2WND0
      RDATA(3)= Y1WND0
      RDATA(4)= Y2WND0
      CALL G3LINK(7,5,4*NBYTR,IDATA,RDATA)
      CALL POSITN(X1WND0,Y1WND0)
C
      RETURN
      END
