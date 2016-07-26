      SUBROUTINE PTPLOT(XPOSNS,YPOSNS,ISTART,ISTOP,MARKNO)
C
C          ------------------------------------------------
C          ROUTINE NO. (  80)   VERSION (A8.6)    05:JUN:87
C          ------------------------------------------------
C
C          THIS PUTS A MARKER CHARACTER AT EACH POINT.
C
C
C          [XPOSNS] ARE THE X-COORDINATES OF THE POINTS.
C          [YPOSNS] ARE THE Y-COORDINATES OF THE POINTS.
C          <ISTART> IS THE LOWER BOUNDARY AND
C          <ISTOP>  IS THE UPPER BOUNDARY OF THE ARRAY.
C          <MARKNO> GIVES THE MARKER CHAR. IN SET 0;
C                   HOWEVER, IF THE NUMBER IS ZERO, THE
C                   PREVIOUS MARKER IS USED INSTEAD.
C
C
      REAL    RDATA(2),XPOSNS(ISTOP),YPOSNS(ISTOP)
      INTEGER IDATA(1)
C
      COMMON /T0KFIL/ KOLFL0
      COMMON /T0MRKS/ MARKC0
      COMMON /T0PPOS/ XPLOT0,YPLOT0
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
      COMMON /T3NBYR/ NBYTR
C
      DATA RDATA /0.0,0.0/
C
C
      ITRAC1= ISTART
      ITRAC2= ISTOP
      ITRAC3= MARKNO
      IF (IPRINT.EQ.1) CALL G0MESG(32,7)
      IF (ISTART.GT.ISTOP) RETURN
C
C          AUTOMATIC MAPPING WILL BE DONE IF NECESSARY.
C
      CALL G0AUTO(XPOSNS,YPOSNS,ISTART,ISTOP,ISTART,ISTOP,0)
      IF (KOLFL0.EQ.0) GO TO 1
C
      IDATA(1)= 0
      IF (KOLFL0.LT.0) IDATA(1)= 1
C
      CALL G3LINK(5,13,-1,IDATA,RDATA)
      IDATA(1)= IABS(KOLFL0)
      CALL G3LINK(5,3,-1,IDATA,RDATA)
      CALL POSITN(XPOSNS(ISTART),YPOSNS(ISTART))
      LOLIM= ISTART+1
C
      DO 100 IJOIN= LOLIM,ISTOP
        CALL JOIN(XPOSNS(IJOIN),YPOSNS(IJOIN))
  100 CONTINUE
C
      CALL JOIN(XPOSNS(ISTART),YPOSNS(ISTART))
      CALL G3LINK(5,4,0,IDATA,RDATA)
    1 KCHAR= IABS(MARKNO)
      IF (KCHAR.EQ.0.OR.KCHAR.GT.255) GO TO 2
C
      MARKC0= KCHAR
      IDATA(1)= KCHAR
      CALL G3LINK(2,9,-1,IDATA,RDATA)
C
    2 DO 200 JUMP= ISTART,ISTOP
        RDATA(1)= XPOSNS(JUMP)
        RDATA(2)= YPOSNS(JUMP)
        CALL G3LINK(0,5,2*NBYTR,IDATA,RDATA)
  200 CONTINUE
C
      XPLOT0= XPOSNS(ISTOP)
      YPLOT0= YPOSNS(ISTOP)
C
      RETURN
      END
