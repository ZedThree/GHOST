      SUBROUTINE INCHIS(XORIG,YORIG,BARWID,VALSTS,ISTART,ISTOP,NOVALS,
     &                  NOSETS)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 116)   VERSION (A8.1)    23:JUN:87
C          ------------------------------------------------
C
C          THIS DRAWS A SET OF HISTOGRAMS FROM GIVEN VALUES.
C          BARS CAN BE HORIZONTAL OR VERTICAL.
C          THIS USES INCREMENTAL VALUES.
C
C
C          THE ARGUMENTS ARE AS FOLLOWS:
C
C          <XORIG>  IS THE X-ORIGIN OF THE GRAPH,
C          <YORIG>  IS THE Y-ORIGIN OF THE GRAPH,
C          <BARWID> IS THE THICKNESS OF THE BARS,
C          [VALSTS] ARE THE VALUES TO BE GRAPHED,
C          <ISTART> IS THE LOWER BOUNDARY, AND
C          <ISTOP>  IS THE UPPER BOUNDARY OF THE BAR NUMBERS,
C          <NOVALS> IS THE TOTAL NUMBER OF BARS IN THE VALUES ARRAY,
C          <NOSETS> IS THE TOTAL NUMBER OF SETS OF BARS IN THE VALUES ARRAY.
C
C
      REAL    BAUTO(2),VAUTO(2),VALSTS(NOVALS,NOSETS),RDATA(1)
      INTEGER IDATA(1)
C
      COMMON /T0BRTY/ IBRTYP
      COMMON /T0KLST/ LSTCL0(100),LENLST
      COMMON /T0MULF/ INFLGS(100)
      COMMON /T0PPOS/ XPLOT0,YPLOT0
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAR/ RTRAC1,RTRAC2,RTRAC3,RTRAC4
      COMMON /T3LIMS/ IMAXI,RMAXI,RMINI
C
      DATA RDATA /0.0/
C
C
      RTRAC1= XORIG
      RTRAC2= YORIG
      RTRAC3= BARWID
      IF (IPRINT.EQ.1) CALL G0MESG(168,3)
C
      BORIG= XORIG
      BASPOS= YORIG
      IF (IBRTYP.EQ.0) GO TO 1
C
      BORIG= YORIG
      BASPOS= XORIG
C
C          AUTOMATIC MAPPING IS DONE FOR THE GIVEN VALUES.
C          THE CURRENT PLOTTING POSITION IS SAVED, THE
C          HISTOGRAM IS DRAWN, THEN THE POSITION IS RESTORED.
C
    1 NUMBR= ISTOP-ISTART+1
      IF (NUMBR.LT.1) RETURN
C
      BAUTO(1)= BORIG
      BAUTO(2)= BORIG+NUMBR*BARWID
      VAUTO(1)= BASPOS
      VAUTO(2)= BASPOS
C
      DO 100 IBRCNT= ISTART,ISTOP
        VAL= BASPOS
C
        DO 200 ISTCNT= 1,NOSETS
          IF (ISTCNT.GT.100) GO TO 2
          IF (INFLGS(ISTCNT).EQ.0) GO TO 200
C
    2     VAL= VAL+ABS(VALSTS(IBRCNT,ISTCNT))
  200   CONTINUE
C
        IF (VAL.GT.VAUTO(2)) VAUTO(2)= VAL
  100 CONTINUE
C
      IF (ABS(BAUTO(2)-BAUTO(1)).LT.RMINI.OR.
     &    ABS(VAUTO(2)-VAUTO(1)).LT.RMINI) RETURN
      IF (IBRTYP.EQ.0) CALL G0AUTO(BAUTO,VAUTO,1,2,1,2,1)
      IF (IBRTYP.NE.0) CALL G0AUTO(VAUTO,BAUTO,1,2,1,2,1)
C
      XHERE= XPLOT0
      YHERE= YPLOT0
      IF (LENLST.LE.0) GO TO 6
C
      BRPOS= BORIG
C
      DO 300 IBAR= ISTART,ISTOP
        BRPOS1=BRPOS+BARWID
        FROM= BASPOS
C
        DO 400 IEASET= 1,NOSETS
          IF (IEASET.GT.100) GO TO 3
          IF (INFLGS(IEASET).EQ.0) GO TO 400
C
    3     KOLIND= MOD(IEASET,LENLST)
          IF (KOLIND.EQ.0) KOLIND= LENLST
          IF (LSTCL0(KOLIND).EQ.0) GO TO 400
C
          IDATA(1)= 0
          IF (LSTCL0(KOLIND).LT.0) IDATA(1)= 1
C
          CALL G3LINK(5,13,-1,IDATA,RDATA)
          IDATA(1)= IABS(LSTCL0(KOLIND))
          CALL G3LINK(5,3,-1,IDATA,RDATA)
          CURVAL= FROM+ABS(VALSTS(IBAR,IEASET))
          IF (IBRTYP.NE.0) GO TO 4
C
          CALL POSITN(BRPOS,FROM)
          CALL JOIN(BRPOS,CURVAL)
          CALL JOIN(BRPOS1,CURVAL)
          CALL JOIN(BRPOS1,FROM)
          CALL JOIN(BRPOS,FROM)
          GO TO 5
C
    4     CALL POSITN(FROM,BRPOS)
          CALL JOIN(CURVAL,BRPOS)
          CALL JOIN(CURVAL,BRPOS1)
          CALL JOIN(FROM,BRPOS1)
          CALL JOIN(FROM,BRPOS)
    5     CALL G3LINK(5,4,0,IDATA,RDATA)
          FROM= CURVAL
  400   CONTINUE
C
        BRPOS= BRPOS1
  300 CONTINUE
C
    6 BRPOS1= BORIG
C
      DO 700 IBAR= ISTART,ISTOP
        BRPOS=  BRPOS1
        BRPOS1= BRPOS+BARWID
        CURVAL= BASPOS
C
        DO 800 ISTCNT= 1,NOSETS
C
C       DO FOR EACH VALUE IN BAR
C
          IF (ISTCNT.GT.100) GO TO 7
          IF (INFLGS(ISTCNT).EQ.0) GO TO 800
C
    7     CURVAL= CURVAL+ABS(VALSTS(IBAR,ISTCNT))
          IF (IBRTYP.NE.0) GO TO 8
C
          CALL POSITN(BRPOS,CURVAL)
          CALL JOIN(BRPOS1,CURVAL)
          GOTO 800
C
    8     CALL POSITN(CURVAL,BRPOS)
          CALL JOIN(CURVAL,BRPOS1)
  800   CONTINUE
C
        IF (IBRTYP.NE.0) GO TO 9
C
        CALL POSITN(BRPOS,BASPOS)
        CALL JOIN(BRPOS,CURVAL)
        CALL POSITN(BRPOS1,CURVAL)
        CALL JOIN(BRPOS1,BASPOS)
        GO TO 700
C
    9   CALL POSITN(BASPOS,BRPOS)
        CALL JOIN(CURVAL,BRPOS)
        CALL POSITN(CURVAL,BRPOS1)
        CALL JOIN(BASPOS,BRPOS1)
  700 CONTINUE
C
C     DRAW BASELINE
C
      IF (IBRTYP.EQ.0) CALL POSITN(BRPOS1,BASPOS)
      IF (IBRTYP.NE.0) CALL POSITN(BASPOS,BRPOS1)
C
      CALL JOIN(XORIG,YORIG)
      CALL POSITN(XHERE,YHERE)
      RETURN
      END