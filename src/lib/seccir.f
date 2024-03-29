      SUBROUTINE SECCIR(XSTART,YSTART,ANGLE)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 105)   VERSION (A8.3)    14:JUL:88
C          ------------------------------------------------
C
C          THIS DRAWS A SECTOR OF A CIRCLE WHICH IS
C          CENTRED ON THE CURRENT PLOTTING POSITION.
C
C
C          <XSTART> IS THE STARTING X-COORDINATE,
C          <YSTART> IS THE STARTING Y-COORDINATE,
C          <ANGLE>  IS THE ARC ANGLE ANTI-CLOCKWISE
C                   FROM THE STARTING POSITION.
C
C
      REAL    RDATA(4)
      INTEGER IDATA(1)
C
      COMMON /T0ACON/ ANGCON
      COMMON /T0DBND/ IDRBND
      COMMON /T0KFIL/ KOLFL0
      COMMON /T0MAPP/ X1MAP0,X2MAP0,Y1MAP0,Y2MAP0
      COMMON /T0PPOS/ XPLOT0,YPLOT0
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAR/ RTRAC1,RTRAC2,RTRAC3,RTRAC4
      COMMON /T3NBYR/ NBYTR
C
      DATA RDATA(4) /1.0/, IDATA /0/
C
C
      RTRAC1= XSTART
      RTRAC2= YSTART
      RTRAC3= ANGLE
      IF (IPRINT.EQ.1) CALL G0MESG(134,3)
C
      RDATA(1)= XSTART-XPLOT0
      RDATA(2)= YSTART-YPLOT0
      ANG= ANGLE*ANGCON
      RDATA(3)= ANG
C
      XC= XPLOT0
      YC= YPLOT0
C
C          CORRECTION IS MADE FOR DIFFERENT
C          SCALING ON THE X AND Y AXES.
C
      YSCALE= (X2MAP0-X1MAP0)/(Y2MAP0-Y1MAP0)
      XE= XPLOT0+(XSTART-XPLOT0)*COS(ANG)
     &    -(YSTART-YPLOT0)*SIN(ANG)*YSCALE
      YE= YPLOT0+(XSTART-XPLOT0)*SIN(ANG)/YSCALE
     &    +(YSTART-YPLOT0)*COS(ANG)
C
      IF (KOLFL0.EQ.0) GO TO 1
C
      IDATA(1)= 0
      IF (KOLFL0.LT.0) IDATA(1)= 1
C
      CALL G3LINK(5,13,-1,IDATA,RDATA)
      IDATA(1)= IABS(KOLFL0)
      CALL G3LINK(5,3,-1,IDATA,RDATA)
      CALL POSITN(XC,YC)
      CALL JOIN(XSTART,YSTART)
      CALL POSITN(XC,YC)
      CALL G3LINK(0,9,4*NBYTR,IDATA,RDATA)
      CALL POSITN(XE,YE)
      CALL JOIN(XC,YC)
      CALL G3LINK(5,4,0,IDATA,RDATA)
      IF (IDRBND.EQ.0) RETURN
C
    1 CALL POSITN(XC,YC)
      CALL JOIN(XSTART,YSTART)
      CALL POSITN(XC,YC)
      CALL G3LINK(0,9,4*NBYTR,IDATA,RDATA)
      CALL POSITN(XE,YE)
      CALL JOIN(XC,YC)
C
      RETURN
      END
