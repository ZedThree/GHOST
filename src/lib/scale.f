      SUBROUTINE SCALE(SCALMX,SCALMY)
C
C          ------------------------------------------------
C          ROUTINE NO. (  31)   VERSION (A7.5)    11:FEB:85
C          ------------------------------------------------
C
C          THIS SETS SUBSEQUENT PICTURE X AND Y SCALING.
C
C
C          THE ARGUMENTS ARE AS FOLLOWS:
C
C          <SCALMX> IS THE X-DIRECTION SCALING FACTOR,
C          <SCALMY> IS THE Y-DIRECTION SCALING FACTOR.
C
C
      REAL    RDATA(1)
      INTEGER IDATA(1)
      LOGICAL SHIFT0
C
      COMMON /T0PPOS/ XPLOT0,YPLOT0
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAN/ SCALX0,SCALY0,ROTAT0,RPICX0,RPICY0,RDEVX0,RDEVY0,
     &                VRPICX,VRPICY,VRDEVX,VRDEVY
      COMMON /T0TRAR/ RTRAC1,RTRAC2,RTRAC3,RTRAC4
      COMMON /T0TRST/ SHIFT0,MTRAN0,KLIPM0
      COMMON /T3NBYR/ NBYTR
C
      DATA IDATA /0/
C
C
      CALL G3INIT(2)
C
      RTRAC1= SCALMX
      RTRAC2= SCALMY
      IF (IPRINT.EQ.1) CALL G0MESG(15,2)
C
      SCALX0=   SCALMX
      RDATA(1)= SCALMX
      CALL G3LINK(7,8,NBYTR,IDATA,RDATA)
      SCALY0=   SCALMY
      RDATA(1)= SCALMY
      CALL G3LINK(7,9,NBYTR,IDATA,RDATA)
C
C          BOTH REFERENCE POINTS ARE UPDATED AS NECESSARY.
C
      VRPICX= XPLOT0
      VRPICY= YPLOT0
      CALL G0MAPP(XPLOT0,YPLOT0,RPICX0,RPICY0)
C
      IF (SHIFT0) RETURN
C
      RDEVX0= RPICX0
      RDEVY0= RPICY0
C
      RETURN
      END
