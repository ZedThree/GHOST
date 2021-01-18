      SUBROUTINE AXEYLI(DIX)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 202)   VERSION (A7.6)    11:FEB:85
C          ------------------------------------------------
C
C          THIS DRAWS AXES WITH (OPTIONAL) ANNOTATION,
C          WITH THE X-INTERVAL SET BY <DIX>.
C
C
C          [X-LINEAR, Y-LOGARITHMIC MARKING].
C
C
      REAL    RDATA(1)
      INTEGER IDATA(1)
C
      COMMON /T0APOS/ AXPOSX,AXPOSY
      COMMON /T0CSPA/ X1CHR0,X2CHR0,Y1CHR0,Y2CHR0
      COMMON /T0PPOS/ XPLOT0,YPLOT0
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAR/ RTRAC1,RTRAC2,RTRAC3,RTRAC4
      COMMON /T0WNDO/ X1WND0,X2WND0,Y1WND0,Y2WND0
      COMMON /T3LIMS/ IMAXI,RMAXI,RMINI
C
      DATA RDATA /0.0/
C
C
      RTRAC1= DIX
      IF (IPRINT.EQ.1) CALL G0MESG(79,1)
C
C          IF THE WINDOW AREA IS WRONG, NOTHING MORE IS
C          DONE. OTHERWISE, THE CURRENT C-SPACE ARGUMENTS
C          ARE SAVED AND C-SPACE IS SWITCHED OFF, THEN
C          THE CURRENT PLOTTING POSITION IS STORED.
C
      IF (ABS(X1WND0-X2WND0).LT.RMINI.OR.
     &    ABS(Y1WND0-Y2WND0).LT.RMINI) RETURN
      IF (SIGN(1.0,Y1WND0)*SIGN(1.0,Y2WND0).LE.0.0) RETURN
C
      IPRSAV= IPRINT
      IPRINT= 0
      XCSAV1= X1CHR0
      XCSAV2= X2CHR0
      YCSAV1= Y1CHR0
      YCSAV2= Y2CHR0
      CALL CSPACE(0.0,0.0,0.0,0.0)
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
      IF (ABS(AXPOSX).LT.RMINI) AXPOSX= Y1WND0
C
      CALL G0DIVS(-1,DIX)
      CALL G0TICK
      CALL G0PLAX(1)
      CALL G0DIVL(-2)
      CALL G0TICK
      CALL G0PLYL(1)
C
      IDATA(1)= 0
      CALL G3LINK(0,14,-1,IDATA,RDATA)
C
C          FINALLY, THE PREVIOUS CHAR.-SPACE
C          AND PLOTTING POSITION ARE RESTORED.
C
      CALL CSPACE(XCSAV1,XCSAV2,YCSAV1,YCSAV2)
      CALL POSITN(XHERE,YHERE)
      AXPOSX= AXXSAV
      IPRINT= IPRSAV
C
      RETURN
      END
