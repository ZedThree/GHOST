      SUBROUTINE PTJOIN(XPOSNS,YPOSNS,ISTART,ISTOP,IOPEN)
C
C          ------------------------------------------------
C          ROUTINE NO. (  83)   VERSION (A8.4)    14:JUL:88
C          ------------------------------------------------
C
C          THIS JOINS A SET OF POINTS WITH STRAIGHT-LINE SEGMENTS.
C
C
C          [XPOSNS] ARE THE X-COORDINATES OF THE POINTS.
C          [YPOSNS] ARE THE Y-COORDINATES OF THE POINTS.
C          <ISTART> IS THE LOWER BOUNDARY AND
C          <ISTOP>  IS THE UPPER BOUNDARY OF THE ARRAY.
C          <IOPEN>  DETERMINES THE CURVE TYPE:
C                   >= 0, THE CURVE IS OPEN, OR
C                   < 0, IT IS CLOSED.
C
C
      REAL    RDATA(1),XPOSNS(ISTOP),YPOSNS(ISTOP)
      INTEGER IDATA(1)
C
      COMMON /T0DBND/ IDRBND
      COMMON /T0KFIL/ KOLFL0
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
C
      DATA RDATA /0.0/
C
C
      ITRAC1= ISTART
      ITRAC2= ISTOP
      ITRAC3= IOPEN
      IF (IPRINT.EQ.1) CALL G0MESG(109,7)
      IF (ISTART.GE.ISTOP) RETURN
C
C          AUTOMATIC MAPPING WILL BE DONE IF NECESSARY.
C
      CALL G0AUTO(XPOSNS,YPOSNS,ISTART,ISTOP,ISTART,ISTOP,0)
      IF (IOPEN.GE.0.OR.KOLFL0.EQ.0) GO TO 1
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
      IF (IDRBND.EQ.0) RETURN
C
    1 CALL POSITN(XPOSNS(ISTART),YPOSNS(ISTART))
      LOLIM= ISTART+1
C
      DO 200 IJOIN= LOLIM,ISTOP
        CALL JOIN(XPOSNS(IJOIN),YPOSNS(IJOIN))
  200 CONTINUE
C
      IF (IOPEN.LT.0) CALL JOIN(XPOSNS(ISTART),YPOSNS(ISTART))
C
      RETURN
      END
