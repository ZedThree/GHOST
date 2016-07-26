      SUBROUTINE G1CONC(XPOS,YPOS,THETA,ELONG)
C
C          ------------------------------------------------
C          ROUTINE NO. (1022)   VERSION (A7.7)    11:FEB:85
C          ------------------------------------------------
C
C          THIS GENERATES ELLIPTICAL ARCS CENTRED
C          ABOUT THE CURRENT PLOTTING POSITION.
C
C          THE ARGUMENTS ARE:
C
C          <XPOS>   IS THE START-POSITION X-COORDINATE,
C          <YPOS>   IS THE START-POSITION Y-COORDINATE
C                   (BOTH RELATIVE TO THE CURRENT PLOTTING POSITION),
C          <THETA>  IS THE ANGLE SUBTENDED BY THE ARC (IN RADIANS),
C          <ELONG>  IS THE RATIO OF MAJOR:MINOR AXES LENGTHS.
C
C
      COMMON /T1CPOS/ XCHAR,YCHAR
      COMMON /T1DRES/ DRESX,DRESY
      COMMON /T1PPAT/ XPLOTA,YPLOTA
      COMMON /T1PPBT/ XPLOTB,YPLOTB
      COMMON /T3CONS/ PI
C
C
C          FIRSTLY THE CURRENT POSITIONS ARE STORED.
C
      XSAVEB= XPLOTB
      YSAVEB= YPLOTB
      XSAVEA= XPLOTA
      YSAVEA= YPLOTA
      XSAVEC= XCHAR
      YSAVEC= YCHAR
C
C          THE ELLIPSE CONSTANTS ARE THEN CALCULATED,
C          AND THE REQUIRED PORTION OF THE CURVE IS DRAWN.
C
      DIST= 13.0*DRESX*SQRT(XPOS*XPOS+YPOS*YPOS*ELONG*ELONG)
      IF (DIST.LE.0.0) RETURN
C
      NPTS= MAX0(8,INT(SQRT(DIST)))
      NPTS= MIN0(500,NPTS)*(ABS(THETA)/(2.0*PI))
      IF (NPTS.LE.0) NPTS= 1
C
      DANGL= THETA/NPTS
      COSDA= COS(DANGL)
      SINDA= SIN(DANGL)
      RATIO= ABS(ELONG)
      COEFXX=  COSDA
      COEFXY= -SINDA*RATIO
      COEFYX=  SINDA/(COSDA*RATIO)
      COEFYY=  1.0/COSDA
C
      XNEW= XPOS
      YNEW= YPOS
      XARG= XNEW+XSAVEB
      YARG= YNEW+YSAVEB
      CALL G1LINE(XARG,YARG,.FALSE.)
      DO 100 IPT= 1,NPTS
        XNEW= COEFXX*XNEW+COEFXY*YNEW
        YNEW= COEFYX*XNEW+COEFYY*YNEW
        XARG= XNEW+XSAVEB
        YARG= YNEW+YSAVEB
        CALL G1LINE(XARG,YARG,.TRUE.)
  100 CONTINUE
C
C          LASTLY, THE CURRENT POSITIONS ARE RESTORED.
C
      XPLOTB= XSAVEB
      YPLOTB= YSAVEB
      XPLOTA= XSAVEA
      YPLOTA= YSAVEA
      XCHAR=  XSAVEC
      YCHAR=  YSAVEC
C
      RETURN
      END