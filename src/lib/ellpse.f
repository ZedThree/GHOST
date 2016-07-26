      SUBROUTINE ELLPSE(AXMAJR,AXMINR)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 101)   VERSION (A8.5)    14:JUL:88
C          ------------------------------------------------
C
C          THIS DRAWS AN ELLIPSE CENTRED ON
C          THE CURRENT PLOTTING POSITION.
C
C
C          <AXMAJR>  IS 1/2 THE LENGTH OF THE MAJOR AXIS.
C          <AXMINR>  IS 1/2 THE LENGTH OF THE MINOR AXIS.
C
C
      REAL    RDATA(2)
      INTEGER IDATA(1)
C
      COMMON /T0DBND/ IDRBND
      COMMON /T0KFIL/ KOLFL0
      COMMON /T0MAPP/ X1MAP0,X2MAP0,Y1MAP0,Y2MAP0
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAR/ RTRAC1,RTRAC2,RTRAC3,RTRAC4
      COMMON /T3NBYR/ NBYTR
C
      DATA RDATA /0.0,0.0/, IDATA /0/
C
C
      RTRAC1= AXMAJR
      RTRAC2= AXMINR
      IF (IPRINT.EQ.1) CALL G0MESG(43,2)
C
C          CORRECTION IS MADE FOR DIFFERENT
C          SCALING ON THE X AND Y AXES.
C
      RDATA(1)= ABS(AXMAJR)
      RDATA(2)= ABS(AXMINR)
      RDATA(2)= RDATA(1)*(Y2MAP0-Y1MAP0)/(RDATA(2)*(X2MAP0-X1MAP0))
      IF (KOLFL0.EQ.0) GO TO 1
C
      IDATA(1)= 0
      IF (KOLFL0.LT.0) IDATA(1)= 1
C
      CALL G3LINK(5,13,-1,IDATA,RDATA)
      IDATA(1)= IABS(KOLFL0)
      CALL G3LINK(5,3,-1,IDATA,RDATA)
      CALL G3LINK(0,8,2*NBYTR,IDATA,RDATA)
      CALL G3LINK(5,4,0,IDATA,RDATA)
      IF (IDRBND.EQ.0) RETURN
C
    1 CALL G3LINK(0,8,2*NBYTR,IDATA,RDATA)
C
      RETURN
      END