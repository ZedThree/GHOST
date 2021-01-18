      SUBROUTINE CONTRF(SURFAS,ISTRTX,ISTOPX,NPTSX,ISTRTY,ISTOPY,NPTSY,
     &                  CLEVLS,ISTRTL,ISTOPL)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 183)   VERSION (A9.1)    18:JUL:95
C          ------------------------------------------------
C
C          THIS COLOURS OR HATCHES THE AREAS BETWEEN
C          STRAIGHT-ELEMENT CONTOURS ON A REGULAR GRID.
C
C
C          THE ARGUMENTS ARE AS FOLLOWS:
C
C          [SURFAS]  IS THE ARRAY OF SURFACE HEIGHT VALUES,
C          <ISTRTX>  IS THE LOWER X-EXTENT,
C          <ISTOPX>  IS THE UPPER X-EXTENT, WHILE
C          <ISTRTY>  AND
C          <ISTOPY>  ARE THE CORRESPONDIMG Y-BOUNDS.
C          <NPTSX>   IS THE ACTUAL ARRAY X-EXTENT, AND
C          <NPTSY>   IS THE ACTUAL ARRAY Y-EXTENT.
C          [CLEVLS]  CONTAINS THE VALUES OF CONTOUR HEIGHTS,
C          <ISTRTL>  IS THE STARTING POINT, AND
C          <ISTOPL>  IS THE END POINT OF THIS ARRAY.
C
C
C          EACH MESH ELEMENT IS DIVIDED AS FOLLOWS:
C
C               A  ------------------- B
C                  |\               /|
C                  | \             / |
C                  |  \           /  |
C                  |   \         /   |
C                  |    \       /    |
C                  |     \     /     |
C                  |      \   /      |
C                  |       \ /       |
C                  |      E /        |
C                  |       / \       |
C                  |      /   \      |
C                  |     /     \     |
C                  |    /       \    |
C                  |   /         \   |
C                  |  /           \  |
C                  | /             \ |
C                  |/               \|
C               C  -------------------  D
C
C
      REAL    SURFAS(NPTSX,NPTSY),CLEVLS(ISTOPL),ARG(2)
      LOGICAL ERRON
      LOGICAL JOIN
C
      COMMON /T0PPOS/ XPLOT0,YPLOT0
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
      COMMON /T0WNDO/ X1WND0,X2WND0,Y1WND0,Y2WND0
      COMMON /T3ERRS/ ERRON,NUMERR
C
      DATA DUM /0.0/, ARG /0.0,1.0/
C
C
      ITRAC1= ISTRTX
      ITRAC2= ISTOPX
      ITRAC3= ISTRTY
      ITRAC4= ISTOPY
      IF (IPRINT.EQ.1) CALL G0MESG(27,8)
C
      ILENX= ISTOPX-ISTRTX
      ILENY= ISTOPY-ISTRTY
      IF (ISTRTX.LT.1.OR.ISTRTY.LT.1)         GO TO 901
      IF (ILENX.LT.1.OR.ILENY.LT.1)           GO TO 901
      IF (ISTOPX.GT.NPTSX.OR.ISTOPY.GT.NPTSY) GO TO 901
      IF (ISTRTL.LT.1.OR.ISTRTL.GT.ISTOPL)    RETURN
      IF (ISTRTL.LT.ISTOPL) THEN
C
        DO 100 I= ISTRTL,ISTOPL-1
          IF (CLEVLS(I).GE.CLEVLS(I+1))       GO TO 902
  100   CONTINUE
C
      ENDIF
C
C          THE ROUTE-TRACING FLAG AND THE BOUNDARY DRAWING
C          FLAG ARE SAVED AND SET TO ZERO.
C
      IPRSAV= IPRINT
      IPRINT= 0
      CALL G0AUTO(ARG,ARG,1,2,1,2,1)
      XHERE= XPLOT0
      YHERE= YPLOT0
      ISTPX1= ISTOPX-1
      ISTPY1= ISTOPY-1
C
      DO 200 ISTPTY= ISTRTY,ISTPY1
        YA= Y1WND0+(ISTPTY-ISTRTY+1)*(Y2WND0-Y1WND0)/(ISTOPY-ISTRTY)
        YD= Y1WND0+(ISTPTY-ISTRTY)*(Y2WND0-Y1WND0)/(ISTOPY-ISTRTY)
        JOIN= .FALSE.
C
        DO 300 ISTPTX= ISTRTX,ISTPX1
          XA= X1WND0+(ISTPTX-ISTRTX)*(X2WND0-X1WND0)/(ISTOPX-ISTRTX)
          XD= X1WND0+(ISTPTX-ISTRTX+1)*(X2WND0-X1WND0)/(ISTOPX-ISTRTX)
          VA= SURFAS(ISTPTX,ISTPTY+1)
          VB= SURFAS(ISTPTX+1,ISTPTY+1)
          VC= SURFAS(ISTPTX,ISTPTY)
          VD= SURFAS(ISTPTX+1,ISTPTY)
C
C          TEST TO SEE IF THE RECTANGLE NEEDS JUST ONE COLOUR.
C
          VHI= AMAX1(VA,VB,VC,VD)
          VLO= AMIN1(VA,VB,VC,VD)
          CALL G0CFL4(VHI,VLO,CLEVLS,ISTRTL,ISTOPL,NINTS)
          IF (NINTS.NE.0) GO TO 2
C
C          THE RECTANGLE IS ALL THE SAME COLOUR.
C          TEST TO SEE IF IT CAN BE JOINED TO THE PREVIOUS RECTANGLE.
C
          IF (JOIN) GO TO 1
C
C          START OF NEW RECTANGLE GROUP.  FIND THE COLOUR TO USE.
C
          INDCL= 1
          VAV= (VHI+VLO)*0.5
C
          DO 400 K= ISTRTL,ISTOPL
            IF (VAV.GT.CLEVLS(K)) INDCL= INDCL+1
  400     CONTINUE
C
          XASAV= XA
          JOIN= .TRUE.
C
C          IS THIS THE LAST RECTANGLE OF THE ROW?
C
    1     IF (ISTPTX.LT.ISTPX1) GO TO 300
C
          XA= XD
C
C          THIS IS EITHER THE LAST RECTANGLE OF THE ROW
C          OR THE RECTANGLE IS NOT ALL THE SAME COLOUR.
C
    2     IF (.NOT.JOIN) GO TO 3
C
C          IF THIS IS THE LAST RECTANGLE OF THE ROW OR A
C          RECTANGLE HAS BEEN SAVED, THEN FILL THE RECTANGLE.
C
          CALL G0CFL5(INDCL,4,XASAV,XA,XA,XASAV,DUM,YA,YA,YD,YD,DUM)
          JOIN= .FALSE.
          IF (NINTS.EQ.0) GO TO 300
C
C          EXAMINE EACH TRIANGLE IN TURN.
C
    3     VE= 0.25*(VA+VB+VC+VD)
          XE= 0.5*(XA+XD)
          YE= 0.5*(YA+YD)
          CALL G0CFL1(XA,XA,XE,YD,YA,YE,VC,VA,VE,CLEVLS,ISTRTL,ISTOPL)
          CALL G0CFL1(XA,XD,XE,YA,YA,YE,VA,VB,VE,CLEVLS,ISTRTL,ISTOPL)
          CALL G0CFL1(XD,XD,XE,YA,YD,YE,VB,VD,VE,CLEVLS,ISTRTL,ISTOPL)
          CALL G0CFL1(XD,XA,XE,YD,YD,YE,VD,VC,VE,CLEVLS,ISTRTL,ISTOPL)
  300   CONTINUE
  200 CONTINUE
C
C          THE ENTRY STATE IS ALWAYS RESTORED BEFORE ENDING.
C
      CALL POSITN(XHERE,YHERE)
      IPRINT= IPRSAV
      RETURN
C
  901 NUMERR= 50
      IF (ERRON) CALL G0ERMS
      RETURN
C
  902 NUMERR= 52
      IF (ERRON) CALL G0ERMS
      RETURN
C
      END
