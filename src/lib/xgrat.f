      SUBROUTINE XGRAT
C
C          ------------------------------------------------
C          ROUTINE NO. ( 219)   VERSION (A8.6)    24:NOV:86
C          ------------------------------------------------
C
C          THIS DRAWS AN X-GRATICULE WITH NO ANNOTATION,
C          SETTING THE AXIS INTERVALS AUTOMATICALLY.
C
C
C          [X-LINEAR MARKING].
C
C
      REAL    RDATA(1)
      INTEGER IDATA(1)
C
      COMMON /T0ADIX/ DIVLX,NTIKLX,NTIKHX
      COMMON /T0NOTA/ NOTATA
      COMMON /T0PPOS/ XPLOT0,YPLOT0
      COMMON /T0TRAC/ IPRINT
      COMMON /T0WNDO/ X1WND0,X2WND0,Y1WND0,Y2WND0
      COMMON /T3LIMS/ IMAXI,RMAXI,RMINI
C
      DATA RDATA /0.0/
C
C
      IF (IPRINT.EQ.1) CALL G0MESG(97,0)
C
C          IF THE WINDOW AREA IS WRONG, NOTHING MORE IS DONE.
C          THE ANNOTATION MARKER IS SAVED AND THEN SET = 0
C          SO THAT ANNOTATION IS NOT DONE WITH A GRATICULE.
C          THE CURRENT PLOTTING POSITION IS THEN SAVED.
C
      IF (ABS(X2WND0-X1WND0).LT.RMINI) RETURN
C
      NTATSV= NOTATA
      NOTATA= 0
      XHERE= XPLOT0
      YHERE= YPLOT0
C
C          THE X-AXIS GRATICULE LINES ARE DRAWN.
C
      IDATA(1)= 1
      CALL G3LINK(0,14,-1,IDATA,RDATA)
      CALL G0DIVS(1,0.0)
      NTICKS= NTIKHX-NTIKLX+1
      IF (NTICKS.LE.0) GO TO 1
C
      DO 100 ITICK= 1,NTICKS
        XPOS= DIVLX*(NTIKLX+ITICK-1)
        CALL POSITN(XPOS,Y1WND0)
        CALL JOIN(XPOS,Y2WND0)
  100 CONTINUE
C
    1 IDATA(1)= 0
      CALL G3LINK(0,14,-1,IDATA,RDATA)
C
C          THE ANNOTATION MARKER AND THE CURRENT
C          PLOTTING POSITION ARE THEN RESTORED.
C
      NOTATA= NTATSV
      CALL POSITN(XHERE,YHERE)
C
      RETURN
      END