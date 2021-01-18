      SUBROUTINE G1CLS0(IFUNCO,LENGTH,IDATA,RDATA)
C
C          ------------------------------------------------
C          ROUTINE NO. (1011)   VERSION (A8.7)    07:NOV:96
C          ------------------------------------------------
C
C          THIS PROVIDES VECTOR-DRAWING OPERATIONS.
C
C
C          THE ARGUMENTS ARE AS FOLLOWS:
C
C          <IFUNCO> GIVES THE FUNCTION CODE:
C                   =  1, PLOT A POINT AT THE CPP,
C                   =  2, MOVE PLOT POSITION       (X,Y),
C                   =  3, DRAW POLYLINE            (X1,Y1,....XN,YN),
C                   =  4, DRAW POLYMARKLINE        (X1,Y1,....XN,YN),
C                   =  5, DRAW POLYMARKER          (X1,Y1,....XN,YN),
C                   =  6, SET SHORT-VECTOR SCALING (U,V),
C                   =  7, DRAW SHORT-VECTOR STRING (L1,M1,....LN,MN),
C                   =  8, DRAW CLOSED CONIC        (A,T),
C                   =  9, DRAW CONIC ARC           (X0,Y0,THETA,T),
C                   = 10, SET CURVE TYPE           (N),
C                   = 11, SET CURVE METHOD         (N),
C                   = 12, DRAW PARTIAL CURVE       (X1,Y1,....XN,YN),
C                   = 13, DRAW COMPLETE CURVE      (X1,Y1,....XN,YN),
C                   = 14, SET WINDOW VECTOR MODE   (N).
C          <LENGTH> GIVES THE DATA LENGTH (IN BYTES),
C          [IDATA]  IS THE INTEGER DATA ARRAY, AND
C          [RDATA]  IS THE ALTERNATIVE REAL DATA ARRAY.
C
C
      REAL    RDATA(*)
      INTEGER IDATA(*)
      LOGICAL VISIBL,MRKING,COMPLT,LASTPT
      LOGICAL TYPMOD,OPEN,LHRDW1,LINSAV,OPCURV,TYPSAV,
     &        WINLIN,WNDOIN,MASKIN,CURTRA,SHIFT1
C
      COMMON /T1C2SV/ LPSAV(4)
      COMMON /T1CATT/ IUNDL1,ITAL1
      COMMON /T1CDCC/ SINCHR,COSCHR
      COMMON /T1CMOD/ TYPMOD
      COMMON /T1CPOS/ XCHAR,YCHAR
      COMMON /T1CURV/ MCURV1,OPCURV
      COMMON /T1DENA/ OPEN
      COMMON /T1DLIM/ DLIMX,DLIMY
      COMMON /T1DRES/ DRESX,DRESY
      COMMON /T1HRDL/ LHRDW1
      COMMON /T1LPAT/ MARKA1,MISSA1,MARKB1,MISSB1
      COMMON /T1LVIS/ WINLIN,WNDOIN,MASKIN
      COMMON /T1MASK/ X1MSK1(10),X2MSK1(10),Y1MSK1(10),Y2MSK1(10),MSKLV1
      COMMON /T1MRKS/ MARKC1
      COMMON /T1PPAT/ XPLOTA,YPLOTA
      COMMON /T1PPBT/ XPLOTB,YPLOTB
      COMMON /T1PPOS/ XPLOT1,YPLOT1
      COMMON /T1SHVS/ ISHRTX,ISHRTY,CLONGX,CLONGY
      COMMON /T1TCOC/ XCCX,XCCY,YCCX,YCCY,RPICXC,RPICYC,RDEVXC,RDEVYC,
     &                CURTRA
      COMMON /T1TRST/ SHIFT1,MTRAN1,KLIPM1,INDLVL
      COMMON /T1WNDO/ X1WND1,X2WND1,Y1WND1,Y2WND1
      COMMON /T3NBYR/ NBYTR
C
C
      IF (IFUNCO.LT.1.OR.IFUNCO.GT.14) RETURN
C
      NVECS= IABS(LENGTH)/(2*NBYTR)
      GO TO (1,5,6,7,8,10,11,12,13,14,15,16,17,19), IFUNCO
C
C          IF THE CURRENT CHANNEL IS NOT ON, NOTHING IS DONE.
C          OTHERWISE, THE FOLLOWING SECTION WILL PLOT A POINT
C          PROVIDED IT IS WITHIN THE WINDOW AND ALSO OUTSIDE
C          ALL OF THE CURRENT RECTANGULAR MASKING AREAS.
C
    1 IF (.NOT.OPEN) RETURN
C
      XTRY= XPLOTB
      YTRY= YPLOTB
      XCHAR= XPLOTB
      YCHAR= YPLOTB
      IF (KLIPM1.NE.0.OR.MTRAN1.EQ.0.OR.MTRAN1.EQ.2) GO TO 2
C
      XTRY= XCCX*(XPLOTB-RPICXC)+XCCY*(YPLOTB-RPICYC)+RDEVXC
      YTRY= YCCX*(XPLOTB-RPICXC)+YCCY*(YPLOTB-RPICYC)+RDEVYC
    2 IF (XTRY.LT.X1WND1.OR.XTRY.GT.X2WND1)   RETURN
      IF (YTRY.LT.Y1WND1.OR.YTRY.GT.Y2WND1)   RETURN
      IF (XPLOTA.LT.0.0.OR.YPLOTA.LT.0.0)     RETURN
      IF (XPLOTA.GT.DLIMX.OR.YPLOTA.GT.DLIMY) RETURN
      IF (MSKLV1.EQ.0) GO TO 3
C
      DO 100 LEVEL= 1,MSKLV1
        IF (XTRY.LT.X1MSK1(LEVEL).OR .XTRY.GT.X2MSK1(LEVEL)) GO TO 100
        IF (YTRY.GE.Y1MSK1(LEVEL).AND.YTRY.LE.Y2MSK1(LEVEL)) RETURN
  100 CONTINUE
C
    3 IXNOW= DRESX*XPLOTA
      IYNOW= DRESY*YPLOTA
      CALL G1FILB(IXNOW,IYNOW,-1,0)
      RETURN
C
C          THE FOLLOWING SECTIONS SET CONDITIONS FOR
C          POSITION, POLYLINE, POLYMARKLINE, OR POLYMARKER.
C          LOOP-200 THEN CARRIES OUT THE REQUIRED ACTIONS.
C
    5 VISIBL= .FALSE.
      MRKING= .FALSE.
      GO TO 9
C
    6 VISIBL= .TRUE.
      MRKING= .FALSE.
      GO TO 9
C
    7 VISIBL= .TRUE.
      MRKING= .TRUE.
      GO TO 9
C
    8 VISIBL= .FALSE.
      MRKING= .TRUE.
C
    9 TYPSAV= TYPMOD
      TYPMOD= .FALSE.
      IUNSAV= IUNDL1
      IUNDL1= 0
      SAVCOS= COSCHR
      COSCHR= 1.0
      SAVSIN= SINCHR
      SINCHR= 0.0
C
      DO 200 IPT= 1,NVECS
        IPAIR= IPT*2
        XPLOT1= RDATA(IPAIR-1)
        YPLOT1= RDATA(IPAIR)
        CALL G1MAPP(XPLOT1,YPLOT1,XNORM,YNORM,1)
        CALL G1LINE(XNORM,YNORM,VISIBL)
        XCHAR= XNORM
        YCHAR= YNORM
        IF (.NOT.MRKING.OR.MARKC1.LT.32) GO TO 200
C
        LPSAV(1)= MARKA1
        LPSAV(2)= MISSA1
        LPSAV(3)= MARKB1
        LPSAV(4)= MISSB1
        MARKA1= 0
        MISSA1= 0
        MARKB1= 0
        MISSB1= 0
        LINSAV= LHRDW1
        LHRDW1= .FALSE.
        IF (LINSAV) CALL G1HRDW(1)
C
        CALL G1CHAR(MARKC1)
        MARKA1= LPSAV(1)
        MISSA1= LPSAV(2)
        MARKB1= LPSAV(3)
        MISSB1= LPSAV(4)
        LHRDW1= LINSAV
        IF (LHRDW1) CALL G1HRDW(1)
  200 CONTINUE
C
      TYPMOD= TYPSAV
      IUNDL1= IUNSAV
      COSCHR= SAVCOS
      SINCHR= SAVSIN
      RETURN
C
C          THE NEXT SECTION SETS UP CONDITIONS FOR A SHORT-
C          VECTOR STRING, WHILE THE FOLLOWING ONE CONVERTS
C          THE STRING INTO LONG VECTORS AND DRAWS THEM.
C
   10 CLONGX= RDATA(1)
      CLONGY= RDATA(2)
      RETURN
C
   11 LAST= IABS(LENGTH)
      ISHRTX= 0
      ISHRTY= 0
      X1SAVE= XPLOT1
      Y1SAVE= YPLOT1
C
      DO 300 IPT= 2,LAST,2
        ISHRTX= ISHRTX+IDATA(IPT-1)-128
        ISHRTY= ISHRTY+IDATA(IPT)-128
        XPLOT1= ISHRTX*CLONGX+X1SAVE
        YPLOT1= ISHRTY*CLONGY+Y1SAVE
        CALL G1MAPP(XPLOT1,YPLOT1,XNORM,YNORM,1)
        CALL G1LINE(XNORM,YNORM,.TRUE.)
  300 CONTINUE
C
      XCHAR= XNORM
      YCHAR= YNORM
      RETURN
C
C          THE FOLLOWING SECTIONS DO CLOSED
C          AND OPEN CONIC ARCS RESPECTIVELY.
C
   12 XVEC= RDATA(1)+XPLOT1
      YVEC= 1.0
      CALL G1MAPP(XVEC,YVEC,XNORM,YNORM,1)
      XARG= XNORM-XPLOTB
      CALL G1CONC(XARG,0.0,6.28318531,RDATA(2))
      RETURN
C
   13 XVEC= RDATA(1)+XPLOT1
      YVEC= RDATA(2)+YPLOT1
      CALL G1MAPP(XVEC,YVEC,XNORM,YNORM,1)
      XARG= XNORM-XPLOTB
      YARG= YNORM-YPLOTB
      CALL G1CONC(XARG,YARG,RDATA(3),RDATA(4))
      RETURN
C
C          THIS SECTION SETS THE CURVE TYPE (OPEN OR CLOSED).
C
   14 OPCURV= .TRUE.
      IF (IDATA(1).NE.0) OPCURV= .FALSE.
      RETURN
C
C          THIS SECTION SETS THE CURVE DRAWING METHOD.
C
   15 MCURV1= IDATA(1)
      IF (MCURV1.NE.1.AND.MCURV1.NE.2) MCURV1= 1
      RETURN
C
C          THIS SECTION DRAWS COMPLETE OR INCOMPLETE CURVES.
C
   16 COMPLT= .FALSE.
      GO TO 18
C
   17 COMPLT= .TRUE.
   18 IF (NVECS.LT.1) RETURN
C
      LASTPT= .FALSE.
C
      DO 400 IPT= 1,NVECS
        IPAIR= IPT*2
        XPLOT1= RDATA(IPAIR-1)
        YPLOT1= RDATA(IPAIR)
        CALL G1MAPP(XPLOT1,YPLOT1,XNORM,YNORM,1)
        IF (IPT.EQ.NVECS.AND.COMPLT) LASTPT= .TRUE.
C
        CALL G1CRV1(XNORM,YNORM,LASTPT)
  400 CONTINUE
C
      XCHAR= XNORM
      YCHAR= YNORM
      RETURN
C
C          THIS SECTION ENABLES/DISABLES WINDOW-RELATED VECTORS.
C          WHEN ENABLING THEM, THE CURRENT TRANSFORM IS DISABLED
C          UNLESS CLIPPING TRANSFORMATION MODE 1 IS SET. WHEN
C          DISABLING THEM, THE PREVIOUS TRAN. STATE IS RESTORED.
C
   19 WINLIN= .FALSE.
      IF (IDATA(1).EQ.1) WINLIN= .TRUE.
      IF (WINLIN) GO TO 20
      IF (MTRAN1.EQ.1.OR.MTRAN1.EQ.3) CURTRA= .TRUE.
C
      WNDOIN= .TRUE.
      RETURN
C
   20 IF (KLIPM1.NE.1) CURTRA= .FALSE.
C
      WNDOIN= .FALSE.
      RETURN
      END
