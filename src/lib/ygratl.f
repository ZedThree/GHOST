      SUBROUTINE YGRATL
C
C          ------------------------------------------------
C          ROUTINE NO. ( 230)   VERSION (A8.6)    17:JUN:88
C          ------------------------------------------------
C
C          THIS DRAWS A Y-GRATICULE WITH NO ANNOTATION,
C          SETTING THE AXIS INTERVALS AUTOMATICALLY.
C
C
C          [Y-LOGARITHMIC MARKING].
C
C
      REAL    RDATA(1)
      INTEGER IDATA(1)
C
      COMMON /T0ADIY/ DIVLY,NTIKLY,NTIKHY
      COMMON /T0APOS/ AXPOSX,AXPOSY
      COMMON /T0ASKY/ NSKIPY,NDECSY
      COMMON /T0NOTA/ NOTATA
      COMMON /T0PPOS/ XPLOT0,YPLOT0
      COMMON /T0TRAC/ IPRINT
      COMMON /T0WNDO/ X1WND0,X2WND0,Y1WND0,Y2WND0
      COMMON /T3LIMS/ IMAXI,RMAXI,RMINI
C
      DATA RDATA /0.0/
C
C
      IF (IPRINT.EQ.1) CALL G0MESG(108,0)
C
C          IF THE WINDOW AREA IS WRONG, NOTHING MORE IS DONE.
C          THE ANNOTATION MARKER IS SAVED AND THEN SET = 0
C          SO THAT ANNOTATION IS NOT DONE WITH A GRATICULE.
C          THE CURRENT PLOTTING POSITION IS THEN SAVED.
C
      IF (ABS(Y2WND0-Y1WND0).LT.RMINI) RETURN
C
      NTATSV= NOTATA
      NOTATA= 0
      XHERE= XPLOT0
      YHERE= YPLOT0
C
C          THE Y-AXIS GRATICULE LINES ARE DRAWN.
C          IF THERE ARE MORE THAN 37 SUB-INTERVALS IN THE Y-AXIS,
C          THESE ARE DRAWN AS EDGE TICKS; OTHERWISE THEY ARE DONE
C          AS FULL GRATICULE LINES (JUST AS THE DECADE INTERVALS).
C
      IDATA(1)= 1
      CALL G3LINK(0,14,-1,IDATA,RDATA)
      CALL G0DIVL(2)
      IPOS= NTIKLY
      IDEC= NSKIPY
      NDECS= NDECSY
      NTICKS= NTIKHY
      IF (NTICKS.LE.37) GO TO 1
      IF (IPOS.EQ.1) IDEC= IDEC-1
C
      DO 100 ITICK= 1,NDECS
        YPOS= DIVLY*(10.0**(ITICK+IDEC))
        CALL POSITN(X1WND0,YPOS)
        CALL JOIN(X2WND0,YPOS)
  100 CONTINUE
C
      AXYSAV= AXPOSY
      AXPOSY= X1WND0
      CALL G0TICK
      CALL G0PLYL(0)
      AXPOSY= X2WND0
      CALL G0TICK
      CALL G0PLYL(0)
      AXPOSY= AXYSAV
      GO TO 2
C
    1 IF (NTICKS.LE.0) GO TO 2
C
      DO 200 ITICK= 1,NTICKS
        YPOS= DIVLY*IPOS*(10.0**IDEC)
        CALL POSITN(X1WND0,YPOS)
        CALL JOIN(X2WND0,YPOS)
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
