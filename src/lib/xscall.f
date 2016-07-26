      SUBROUTINE XSCALL
C
C          ------------------------------------------------
C          ROUTINE NO. ( 216)   VERSION (A7.6)    11:FEB:85
C          ------------------------------------------------
C
C          THIS DRAWS AN X-AXIS WITH (OPTIONAL) ANNOTATION
C          ON THE BOTTOM WINDOW EDGE, AND CORRESPONDING TICK
C          MARKS (ONLY) ON THE TOP WINDOW EDGE, SETTING THE
C          MARKING INTERVALS AUTOMATICALLY.
C
C
C          [X-LOGARITHMIC MARKING].
C
C
      REAL    RDATA(1)
      INTEGER IDATA(1)
C
      COMMON /T0ACON/ ANGCON
      COMMON /T0APOS/ AXPOSX,AXPOSY
      COMMON /T0CANG/ STANG0,CRANG0
      COMMON /T0CDIM/ MAGN0,OBLAT0
      COMMON /T0CSPA/ X1CHR0,X2CHR0,Y1CHR0,Y2CHR0
      COMMON /T0MAPP/ X1MAP0,X2MAP0,Y1MAP0,Y2MAP0
      COMMON /T0MAPT/ MAPNO0
      COMMON /T0NOTA/ NOTATA
      COMMON /T0PPOS/ XPLOT0,YPLOT0
      COMMON /T0TRAC/ IPRINT
      COMMON /T0WNDO/ X1WND0,X2WND0,Y1WND0,Y2WND0
      COMMON /T3LIMS/ IMAXI,RMAXI,RMINI
C
      DATA RDATA /0.0/
C
C
      IF (IPRINT.EQ.1) CALL G0MESG(94,0)
C
C          IF THE WINDOW AREA OR THE X-MAPPING IS WRONG,
C          NOTHING MORE IS DONE. OTHERWISE, THE CURRENT
C          CHAR. MAGNIFICATION IS SAVED AND A SUITABLE
C          NEW ONE CALCULATED, THE CURRENT CHAR.-SPACE
C          ARGUMENTS ARE KEPT AND C-SPACE IS SWITCHED OFF,
C          THEN THE CURRENT PLOTTING POSITION IS STORED.
C
      IF (ABS(X1WND0-X2WND0).LT.RMINI.OR.
     &    ABS(Y1WND0-Y2WND0).LT.RMINI) RETURN
C
      IF (MAPNO0.EQ.3.OR.MAPNO0.EQ.4) GO TO 1
      IF (ABS(X1MAP0-X2MAP0).LT.RMINI) RETURN
      FRCWDX= (X2WND0-X1WND0)/(X2MAP0-X1MAP0)
      GO TO 2
C
    1 IF (SIGN(1.0,X1WND0)*SIGN(1.0,X2WND0).LE.0.0) RETURN
      IF (SIGN(1.0,X1MAP0)*SIGN(1.0,X2MAP0).LE.0.0) RETURN
      FRCWDX= ALOG10(X2WND0/X1WND0)/ALOG10(X2MAP0/X1MAP0)
C
    2 IF (MAPNO0.EQ.2.OR.MAPNO0.EQ.4) GO TO 3
      IF (ABS(Y1MAP0-Y2MAP0).LT.RMINI) RETURN
      FRCWDY= (Y2WND0-Y1WND0)/(Y2MAP0-Y1MAP0)
      GO TO 4
C
    3 IF (SIGN(1.0,Y1WND0)*SIGN(1.0,Y2WND0).LE.0.0) RETURN
      IF (SIGN(1.0,Y1MAP0)*SIGN(1.0,Y2MAP0).LE.0.0) RETURN
      FRCWDY= ALOG10(Y2WND0/Y1WND0)/ALOG10(Y2MAP0/Y1MAP0)
C
    4 IPRSAV= IPRINT
      IPRINT= 0
      MAGSAV= MAGN0
      MAG= MIN1(12.5*ABS(FRCWDX),45.0*ABS(FRCWDY))
      IF (MAG.LE.0)   MAG= 1
      IF (MAG.GT.100) MAG= 100
      CALL CTRMAG(MAG)
C
      XCSAV1= X1CHR0
      XCSAV2= X2CHR0
      YCSAV1= Y1CHR0
      YCSAV2= Y2CHR0
      CALL CSPACE(0.0,0.0,0.0,0.0)
C
      STANSV= STANG0
      CRANSV= CRANG0
      OBLSAV= OBLAT0
      CALL CTRANG(0.0)
      CALL CTRORI(0.0)
      CALL CTROBL(1.0)
C
      XHERE= XPLOT0
      YHERE= YPLOT0
C
C          THE TICK MARK POSITIONS AND END POINTS
C          ARE CALCULATED, THEN THE AXIS IS DRAWN.
C
      IDATA(1)= 1
      CALL G3LINK(0,14,-1,IDATA,RDATA)
C
      AXXSAV= AXPOSX
      AXYSAV= AXPOSY
      AXPOSX= Y1WND0
      AXPOSY= X1WND0
C
      CALL G0DIVL(1)
      CALL G0TICK
      CALL G0PLXL(1)
C
      NTATSV= NOTATA
      NOTATA= 0
      AXPOSX= Y2WND0
      AXPOSY= X2WND0
C
      CALL G0TICK
      CALL G0PLXL(0)
C
      IDATA(1)= 0
      CALL G3LINK(0,14,-1,IDATA,RDATA)
C
C          FINALLY, THE PREVIOUS CHARACTER ATTRIBUTES
C          AND PLOTTING POSITION ARE RESTORED.
C
      CALL CTRANG(CRANSV/ANGCON)
      CALL CTRORI(STANSV/ANGCON)
      CALL CTROBL(OBLSAV)
      CALL CTRMAG(MAGSAV)
      CALL CSPACE(XCSAV1,XCSAV2,YCSAV1,YCSAV2)
      CALL POSITN(XHERE,YHERE)
      AXPOSX= AXXSAV
      AXPOSY= AXYSAV
      NOTATA= NTATSV
      IPRINT= IPRSAV
C
      RETURN
      END
