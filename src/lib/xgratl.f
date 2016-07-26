      SUBROUTINE XGRATL
C
C          ------------------------------------------------
C          ROUTINE NO. ( 229)   VERSION (A8.6)    17:JUN:88
C          ------------------------------------------------
C
C          THIS DRAWS AN X-GRATICULE WITH NO ANNOTATION,
C          SETTING THE AXIS INTERVALS AUTOMATICALLY.
C
C
C          [X-LOGARITHMIC MARKING].
C
C
      REAL    RDATA(1)
      INTEGER IDATA(1)
C
      COMMON /T0ADIX/ DIVLX,NTIKLX,NTIKHX
      COMMON /T0APOS/ AXPOSX,AXPOSY
      COMMON /T0ASKX/ NSKIPX,NDECSX
      COMMON /T0NOTA/ NOTATA
      COMMON /T0PPOS/ XPLOT0,YPLOT0
      COMMON /T0TRAC/ IPRINT
      COMMON /T0WNDO/ X1WND0,X2WND0,Y1WND0,Y2WND0
      COMMON /T3LIMS/ IMAXI,RMAXI,RMINI
C
      DATA RDATA /0.0/
C
C
      IF (IPRINT.EQ.1) CALL G0MESG(107,0)
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
C          IF THERE ARE MORE THAN 37 SUB-INTERVALS IN THE AXIS,
C          THESE ARE DRAWN AS EDGE TICKS; OTHERWISE THEY ARE DONE
C          AS FULL GRATICULE LINES (JUST AS THE DECADE INTERVALS).
C
      IDATA(1)= 1
      CALL G3LINK(0,14,-1,IDATA,RDATA)
      CALL G0DIVL(1)
      IPOS= NTIKLX
      IDEC= NSKIPX
      NDECS= NDECSX
      NTICKS= NTIKHX
      IF (NTICKS.LE.37) GO TO 1
      IF (IPOS.EQ.1) IDEC= IDEC-1
C
      DO 100 ITICK= 1,NDECS
        XPOS= DIVLX*(10.0**(ITICK+IDEC))
        CALL POSITN(XPOS,Y1WND0)
        CALL JOIN(XPOS,Y2WND0)
  100 CONTINUE
C
      AXXSAV= AXPOSX
      AXPOSX= Y1WND0
      CALL G0TICK
      CALL G0PLXL(0)
      AXPOSX= Y2WND0
      CALL G0TICK
      CALL G0PLXL(0)
      AXPOSX= AXXSAV
      GO TO 2
C
    1 IF (NTICKS.LE.0) GO TO 2
C
      DO 200 ITICK= 1,NTICKS
        XPOS= DIVLX*IPOS*(10.0**IDEC)
        CALL POSITN(XPOS,Y1WND0)
        CALL JOIN(XPOS,Y2WND0)
        IPOS= IPOS+1
        IF (IPOS.LT.10) GO TO 200
C
        IPOS= 1
        IDEC= IDEC+1
  200 CONTINUE
C
    2 IDATA(1)= 0
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