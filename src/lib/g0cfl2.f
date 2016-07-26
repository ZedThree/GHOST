      SUBROUTINE G0CFL2(XBASE1,XBASE2,XVERT,YBASE1,YBASE2,YVERT,VBASE1,
     &                  VBASE2,VERTEX,CLEVLS,ISTRTL,ISTOPL,NQUADS)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 186)   VERSION (A8.1)    18:MAY:98
C          ------------------------------------------------
C
      REAL CLEVLS(ISTOPL)
C
      DATA DUM /0.0/
C
C
C          SET JSIN TO  1 IF THE LOWEST AREA IS A QUADRILATERAL.
C          SET JSIN TO -1 IF THE LOWEST AREA IS A TRIANGLE.
C
      JSIN= -1
      VBASE= AMAX1(VBASE1,VBASE2)
      IF (VBASE.GT.VERTEX) GO TO 1
C
      JSIN= 1
      VBASE= AMIN1(VBASE1,VBASE2)
C
C          FIND THE FIRST CONTOUR HEIGHT.
C
    1 INDCL=1
      KOLIND= 1
C
      DO 100 I= ISTRTL,ISTOPL
        IF(JSIN.EQ.1.AND.VBASE.LT.CLEVLS(I)) GO TO 100
        IF(JSIN.EQ.-1.AND.VBASE.LE.CLEVLS(I)) GO TO 100
C
        INDCL= INDCL+1
        KOLIND= KOLIND+1
  100 CONTINUE
C
      INDCL= INDCL+(JSIN-1)/2
      XP1= XBASE1
      YP1= YBASE1
      XP2= XBASE2
      YP2= YBASE2
C
C          DO NQUADS QUADRILATERALS.
C
      DO 200 J= 1,NQUADS
        FACTOR= (CLEVLS(INDCL)-VERTEX)/(VERTEX-VBASE1)
        XQ1= XVERT+(XVERT-XBASE1)*FACTOR
        YQ1= YVERT+(YVERT-YBASE1)*FACTOR
        FACTOR= (CLEVLS(INDCL)-VERTEX)/(VERTEX-VBASE2)
        XQ2= XVERT+(XVERT-XBASE2)*FACTOR
        YQ2= YVERT+(YVERT-YBASE2)*FACTOR
        CALL G0CFL5(KOLIND,4,XP1,XQ1,XQ2,XP2,DUM,YP1,YQ1,YQ2,YP2,DUM)
        INDCL= INDCL+JSIN
        KOLIND= KOLIND+JSIN
        XP1= XQ1
        YP1= YQ1
        XP2= XQ2
        YP2= YQ2
  200 CONTINUE
C
C          DO FINAL TRIANGLE.
C
      CALL G0CFL5(KOLIND,3,XP1,XP2,XVERT,DUM,DUM,YP1,YP2,
     &            YVERT,DUM,DUM)
C
      RETURN
      END
