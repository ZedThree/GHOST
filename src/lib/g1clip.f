      SUBROUTINE G1CLIP(IREPLY)
C
C          ------------------------------------------------
C          ROUTINE NO. (1024)   VERSION (A8.3)    26:NOV:86
C          ------------------------------------------------
C
C          THIS DETERMINES HOW A GIVEN LINE INTERACTS WITH A GIVEN
C          RECTANGLE. THE INTERSECTION POINTS ARE FOUND IF POSSIBLE.
C
C
C          THE VALUES IMPORTED ARE:
C
C          <XLIM1>  IS THE LEFTMOST RECTANGLE EDGE.
C          <XLIM2>  IS THE RIGHTMOST RECTANGLE EDGE.
C          <YLIM1>  IS THE LOWER RECTANGLE EDGE.
C          <YLIM2>  IS THE UPPER RECTANGLE EDGE.
C          [POINTS] GIVES THE START AND END POINTS OF THE LINE
C                   (VALUES (<NSTRT>,1&2) AND (<NSTOP>,1&2) RESP.)
C          <NSTRT>  GIVES THE INDEX OF THE START POINT OF THE LINE.
C          <NSTOP>  GIVES THE INDEX OF THE END POINT OF THE LINE.
C
C
C          THE VALUES EXPORTED ARE:
C
C          [STRTPT] IS THE POSITION OF THE 1ST. INTERSECTION,
C          [STOPPT] IS THE POSITION OF THE 2ND. INTERSECTION,
C                   (WHERE THEY EXIST). WITH ONE INTERSECTION,
C                   THE 2ND. POINT IS THE END WHICH IS INSIDE.
C
C
C          THE RETURN ARGUMENT IS:
C
C          <IREPLY> GIVES THE RESULT:
C                   = 0, THE LINE IS WHOLLY INSIDE,
C                   = 1, THE LINE INTERSECTS THE RECTANGLE
C                   = 2, THE LINE IS WHOLLY OUTSIDE.
C
C
      LOGICAL SECT1(4),SECT2(4)
C
      COMMON /T1CLIN/ STRTPT(2),STOPPT(2)
      COMMON /T1CLIP/ XLIM1,XLIM2,YLIM1,YLIM2
      COMMON /T1LINE/ POINTS(22,2),NSTRT,NSTOP
      COMMON /T3LIMS/ IMAXI,RMAXI,RMINI
C
C          THESE FUNCTIONS GIVE THE INTERSECTION POINTS OF THE
C          CURRENT LINE TO X AND Y AXES AT THE GIVEN POSITIONS:
C
      XCUT1(Y)= XEND1+(Y-YEND1)*(DIFFX/DIFFY)
      XCUT2(Y)= XEND2+(Y-YEND2)*(DIFFX/DIFFY)
      YCUT1(X)= YEND1+(X-XEND1)*(DIFFY/DIFFX)
      YCUT2(X)= YEND2+(X-XEND2)*(DIFFY/DIFFX)
      XEND1= POINTS(NSTRT,1)
      YEND1= POINTS(NSTRT,2)
      XEND2= POINTS(NSTOP,1)
      YEND2= POINTS(NSTOP,2)
      DIFFX= XEND1-XEND2
      DIFFY= YEND1-YEND2
      IREPLY= 0
C
    1   DO 100 IPOSN= 1,4
          SECT1(IPOSN)= .FALSE.
          SECT2(IPOSN)= .FALSE.
  100   CONTINUE
C
        IF (XEND1.LT.XLIM1) SECT1(1)= .TRUE.
        IF (XEND2.LT.XLIM1) SECT2(1)= .TRUE.
        IF (XEND1.GT.XLIM2) SECT1(2)= .TRUE.
        IF (XEND2.GT.XLIM2) SECT2(2)= .TRUE.
        IF (YEND1.LT.YLIM1) SECT1(3)= .TRUE.
        IF (YEND2.LT.YLIM1) SECT2(3)= .TRUE.
        IF (YEND1.GT.YLIM2) SECT1(4)= .TRUE.
        IF (YEND2.GT.YLIM2) SECT2(4)= .TRUE.
C
C          IF ALL THE TESTS ARE .FALSE., THE LINE IS INSIDE.
C
        DO 200 IPOSN= 1,4
          IF (SECT1(IPOSN)) GO TO 2
          IF (SECT2(IPOSN)) GO TO 2
  200   CONTINUE
        RETURN
C
C          IF TWO CORRESPONDING TESTS ARE .TRUE., THE
C          LINE IS COMPLETELY OUTSIDE THE CLIP RECTANGLE.
C
    2   IREPLY= 2
        NTRYS1= 0
        NTRYS2= 0
C
        DO 300 IPOSN= 1,4
          IF (SECT1(IPOSN).AND.SECT2(IPOSN)) RETURN
          IF (SECT1(IPOSN)) NTRYS1= NTRYS1+1
          IF (SECT2(IPOSN)) NTRYS2= NTRYS2+1
  300   CONTINUE
C
C          OTHERWISE, THE LINE IS TRUNCATED AT ONE OR BOTH ENDS
C          BY THE LIMIT VALUES AND THE ABOVE TESTS ARE REPEATED.
C
        IREPLY= 1
        IF (NTRYS1.EQ.0)   GO TO 6
        IF (.NOT.SECT1(1)) GO TO 3
C
        YEND1= YCUT2(XLIM1)
        XEND1= XLIM1
        GO TO 6
C
    3   IF (.NOT.SECT1(2)) GO TO 4
C
        YEND1= YCUT2(XLIM2)
        XEND1= XLIM2
        GO TO 6
C
    4   IF (.NOT.SECT1(3)) GO TO 5
C
        XEND1= XCUT2(YLIM1)
        YEND1= YLIM1
        GO TO 6
C
    5   IF (.NOT.SECT1(4)) GO TO 6
C
        XEND1= XCUT2(YLIM2)
        YEND1= YLIM2
C
C          WHEN BOTH END POINTS LIE IN CENTRE-EDGE AREAS, A DOUBLE
C          TRUNCATION IS PREVENTED TO AVOID PERPETUAL SWOPPING OF
C          THE NEW END POINTS WHEN THE LINE IS OUTSIDE THE CLIP AREA.
C
    6   IF (NTRYS2.EQ.0)                 GO TO 10
        IF (NTRYS1.EQ.1.AND.NTRYS2.EQ.1) GO TO 10
        IF (.NOT.SECT2(1)) GO TO 7
C
        YEND2= YCUT1(XLIM1)
        XEND2= XLIM1
        GO TO 10
C
    7   IF (.NOT.SECT2(2)) GO TO 8
C
        YEND2= YCUT1(XLIM2)
        XEND2= XLIM2
        GO TO 10
C
    8   IF (.NOT.SECT2(3)) GO TO 9
C
        XEND2= XCUT1(YLIM1)
        YEND2= YLIM1
        GO TO 10
C
    9   IF (.NOT.SECT2(4)) GO TO 10
C
        XEND2= XCUT1(YLIM2)
        YEND2= YLIM2
C
C          THE NEW END POINTS ARE SAVED BEFORE THE TESTS ARE REPEATED.
C          A LINE WHICH SHRINKS TO A POINT IS DECLARED TO BE OUTSIDE.
C
   10   STRTPT(1)= XEND1
        STRTPT(2)= YEND1
        STOPPT(1)= XEND2
        STOPPT(2)= YEND2
        IF (ABS(XEND2-XEND1).GE.RMINI.OR.
     &      ABS(YEND2-YEND1).GE.RMINI) GO TO 1
C
      IREPLY= 2
      RETURN
      END