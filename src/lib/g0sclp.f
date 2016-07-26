      SUBROUTINE G0SCLP(XPOS,YPOS,INDST,INDEND,XADDPT,YADDPT,INDADD,
     &                  SXPT,SYPT,SVPT,CLEVLS,ISTRTL,ISTOPL,MODE)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 356)   VERSION (A9.1)    06:OCT:92
C          ------------------------------------------------
C
C          THIS ROUTINE CALCULATES A POLYGON TO FILL.
C
      PARAMETER (JSZARR= 600)
      REAL    XPOS(*),YPOS(*),XADDPT(*),YADDPT(*),SXPT(4),SYPT(4),
     &        SVPT(4),SHPT(4),CLEVLS(ISTOPL),XTRIAN(3),YTRIAN(3),
     &        XINT(2,20),YINT(2,20),XINTER(4,20),YINTER(4,20),
     &        XINTR1(2),YINTR1(2),XINTR2(2),YINTR2(2),
     &        XSTORE(JSZARR),YSTORE(JSZARR)
      INTEGER INTNUM(4,20),INTR1(2),INTR2(2),ITRIAN(3),KONKOL(21),
     &        KONINT(20),NOINTS(20)
C
      COMMON /T0INTS/ XLINE1(2),YLINE1(2),XLINE2(2),YLINE2(2)
      COMMON /T3LIMS/ IMAXI,RMAXI,RMINI
C
C
      DO 100 IND= 1,4
        SHPT(IND)= SVPT(IND)
  100 CONTINUE
C
C          ESTABLISH WHETHER THE SURFACE QUADRILATERAL INTERSECTS
C          ITSELF AND, IF SO, MODIFY TWO OF THE SURFACE HEIGHTS.
C
      KTWST1= 0
      KTWST2= 0
      XLINE1(1)= SXPT(1)
      YLINE1(1)= SYPT(1)
      XLINE1(2)= SXPT(2)
      YLINE1(2)= SYPT(2)
      XLINE2(1)= SXPT(3)
      YLINE2(1)= SYPT(3)
      XLINE2(2)= SXPT(4)
      YLINE2(2)= SYPT(4)
      CALL G0INTR(ICODE,XINT1,YINT1)
      IF (ICODE.NE.0) THEN
        IF (SIGN(1.0,(XINT1-SXPT(1))*(SYPT(4)-SYPT(1))-
     &               (YINT1-SYPT(1))*(SXPT(4)-SXPT(1))).LT.0.0) THEN
          SHPT(2)= (SVPT(2)+SVPT(3))*0.5
          SHPT(3)= SHPT(2)
          KTWST1= 2
          KTWST2= 3
        ELSE
          SHPT(4)= (SVPT(4)+SVPT(1))*0.5
          SHPT(1)= SHPT(4)
          KTWST1= 4
          KTWST2= 1
        ENDIF
C
        GO TO 1
      ENDIF
C
      XLINE1(1)= SXPT(2)
      YLINE1(1)= SYPT(2)
      XLINE1(2)= SXPT(3)
      YLINE1(2)= SYPT(3)
      XLINE2(1)= SXPT(4)
      YLINE2(1)= SYPT(4)
      XLINE2(2)= SXPT(1)
      YLINE2(2)= SYPT(1)
      CALL G0INTR(ICODE,XINT1,YINT1)
      IF (ICODE.NE.0) THEN
        IF (SIGN(1.0,(XINT1-SXPT(1))*(SYPT(2)-SYPT(1))-
     &               (YINT1-SYPT(1))*(SXPT(2)-SXPT(1))).GT.0.0) THEN
          SHPT(3)= (SVPT(3)+SVPT(4))*0.5
          SHPT(4)= SHPT(3)
          KTWST1= 3
          KTWST2= 4
        ELSE
          SHPT(1)= (SVPT(1)+SVPT(2))*0.5
          SHPT(2)= SHPT(1)
          KTWST1= 1
          KTWST2= 2
        ENDIF
C
        GO TO 1
      ENDIF
C
C          ESTABLISH WHETHER THE SURFACE QUADRILATERAL IS CONCAVE
C          AND, IF IT IS, MODIFY THE HEIGHT OF THE CONCAVE POINT.
C
      IF ((SXPT(3)-SXPT(2))*(SYPT(4)-SYPT(2)).GT.
     &    (SYPT(3)-SYPT(2))*(SXPT(4)-SXPT(2)))
     &  SHPT(3)= (SVPT(2)+SVPT(4))*0.5
      IF ((SXPT(1)-SXPT(2))*(SYPT(4)-SYPT(2)).LT.
     &    (SYPT(1)-SYPT(2))*(SXPT(4)-SXPT(2)))
     &  SHPT(1)= (SVPT(2)+SVPT(4))*0.5
C
C          FIND THE MIN AND MAX HEIGHTS IN THE SURFACE QUADRILATERAL.
C
    1 INDMIN= 0
C
C          IGNORE ANY TWISTED POINTS ON THE SURFACE QUADRILATERAL.
C
      DO 200 IND= 1,4
        IF (IND.NE.KTWST1.AND.IND.NE.KTWST2) THEN
          IF (INDMIN.EQ.0) THEN
            XMIN= SXPT(IND)
            YMIN= SYPT(IND)
            HMIN= SHPT(IND)
            HMAX= HMIN
            INDMIN= IND
          ELSE
            IF (SHPT(IND).GT.HMAX) HMAX= SHPT(IND)
            IF (SHPT(IND).LT.HMIN) THEN
              XMIN= SXPT(IND)
              YMIN= SYPT(IND)
              HMIN= SHPT(IND)
              INDMIN= IND
            ENDIF
C
          ENDIF
C
        ENDIF
C
  200 CONTINUE
C
C          FIND THE CONTOUR LEVELS THAT INTERSECT THIS QUADRILATERAL.
C
      ILEVLO= ISTOPL+1
      ILEVHI= ISTRTL
C
      DO 300 ICMP= ISTRTL,ISTOPL
        IF (CLEVLS(ICMP).LT.HMAX) ILEVHI= ICMP+1
  300 CONTINUE
C
      DO 400 ICMP= ISTOPL,ISTRTL,-1
        IF (CLEVLS(ICMP).GT.HMIN) ILEVLO= ICMP
  400 CONTINUE
C
      LEVNUM= ILEVLO
C
      IF (ILEVLO.EQ.ILEVHI) GO TO 7
      IF (INDADD.LE.0) RETURN
C
      NOLEVI= 0
      YINTMX= 0.0
C
C          FIND WHERE THE CONTOURS INTERSECT THE SURFACE QUADRILATERAL.
C
      DO 500 ILEV= ILEVLO,ILEVHI-1
        NOLEVI= NOLEVI+1
        INTNO= 0
        CONTLV= CLEVLS(ILEV)
C
        DO 600 ISET= 1,4
          ISET1= MOD(ISET,4)+1
          IF (ABS(CONTLV-SHPT(ISET1)).GE.RMINI.AND.
     &       (CONTLV-SHPT(ISET))*(CONTLV-SHPT(ISET1)).LE.0.0) THEN
            INTNO= INTNO+1
            XINTER(INTNO,NOLEVI)= SXPT(ISET)+(SXPT(ISET1)-SXPT(ISET))*
     &                    (CONTLV-SHPT(ISET))/(SHPT(ISET1)-SHPT(ISET))
            YINTER(INTNO,NOLEVI)= SYPT(ISET)+(SYPT(ISET1)-SYPT(ISET))*
     &                    (CONTLV-SHPT(ISET))/(SHPT(ISET1)-SHPT(ISET))
            INTNUM(INTNO,NOLEVI)= ISET
            IF (YINTER(INTNO,NOLEVI).GT.YINTMX)
     &          YINTMX= YINTER(INTNO,NOLEVI)
C
          ENDIF
C
  600   CONTINUE
C
        NOINTS(NOLEVI)= INTNO
        KONINT(NOLEVI)= ILEV
  500 CONTINUE
C
C          ANALYSE THE INTERSECTIONS.
C
      NOINT2= 0
      NOINT4= 0
C
C          COUNT THE NUMBER OF CONTOURS THAT INTERSECT THE
C          SURFACE QUADRILATERAL TWICE AND FOUR TIMES.
C
      DO 700 ILEV= 1,NOLEVI
        IF (NOINTS(ILEV).EQ.2) THEN
          NOINT2= NOINT2+1
          INDMN1= INTNUM(1,ILEV)
          INDMN2= INTNUM(2,ILEV)
        ENDIF
C
        IF (NOINTS(ILEV).EQ.4) NOINT4= NOINT4+1
  700 CONTINUE
C
      NOLEV= 0
      IF (NOINT2.GT.0.AND.NOINT4.EQ.0) THEN
C
        DO 800 ILEV= 1,NOLEVI
          IF (NOINTS(ILEV).EQ.2) THEN
            NOLEV= NOLEV+1
            XINT(1,NOLEV)= XINTER(1,ILEV)
            YINT(1,NOLEV)= YINTER(1,ILEV)
            XINT(2,NOLEV)= XINTER(2,ILEV)
            YINT(2,NOLEV)= YINTER(2,ILEV)
            KONKOL(NOLEV)= KONINT(ILEV)
          ENDIF
C
  800   CONTINUE
C
        KONKOL(NOLEV+1)= KONKOL(NOLEV)+1
      ELSE
        IF (NOINT2.EQ.0.AND.NOINT4.GT.0) THEN
          INDMN1= INDMIN
          INDMN2= MOD(INDMN1+2,4)+1
        ENDIF
C
        INDMN3= MOD(INDMN2+1,4)+1
        INDMN4= MOD(INDMN1+1,4)+1
C
        DO 900 ILEV= 1,NOLEVI
          IF (NOINTS(ILEV).EQ.2) THEN
            NOLEV= NOLEV+1
            XINT(1,NOLEV)= XINTER(1,ILEV)
            YINT(1,NOLEV)= YINTER(1,ILEV)
            XINT(2,NOLEV)= XINTER(2,ILEV)
            YINT(2,NOLEV)= YINTER(2,ILEV)
            IF (NOINT4.GT.0) THEN
              KONKOL(NOLEV)= KONINT(ILEV)
            ELSE
              KONKOL(NOLEV+1)= KONINT(ILEV)
            ENDIF
C
            NOINT2= NOINT2-1
          ENDIF
C
          IF (NOINTS(ILEV).EQ.4) THEN
            NOLEV= NOLEV+1
            XINT(1,NOLEV)= XINTER(INDMN1,ILEV)
            YINT(1,NOLEV)= YINTER(INDMN1,ILEV)
            XINT(2,NOLEV)= XINTER(INDMN2,ILEV)
            YINT(2,NOLEV)= YINTER(INDMN2,ILEV)
            KONKOL(NOLEV)= KONINT(ILEV)
            ILEVI= NOLEV+NOINT4*2-1
            XINT(1,ILEVI)= XINTER(INDMN3,ILEV)
            YINT(1,ILEVI)= YINTER(INDMN3,ILEV)
            XINT(2,ILEVI)= XINTER(INDMN4,ILEV)
            YINT(2,ILEVI)= YINTER(INDMN4,ILEV)
            KONKOL(ILEVI+1)= KONINT(ILEV)
            NOINT4= NOINT4-1
            IF (NOINT4.EQ.0) THEN
              KONKOL(NOLEV+1)= KONINT(ILEV)+1
              NOLEV= ILEVI
            ENDIF
C
          ENDIF
C
  900   CONTINUE
C
      ENDIF
C
C          FIND THE MINIMUM Y OF THE VISIBLE POLYGON AND COMPARE
C          WITH THE MAXIMUM Y OF THE INTERSECTIONS.
C
      YSURMN= 1.0
      IF (INDADD.GT.0) THEN
C
        DO 1000 ISET= 1,INDADD
         IF (YADDPT(ISET).LT.YSURMN) THEN
           XSURMN= XADDPT(ISET)
           YSURMN= YADDPT(ISET)
         ENDIF
C
 1000   CONTINUE
C
      ENDIF
C
      IF (INDEND.GE.INDST) THEN
C
        DO 1100 ISET= INDST,INDEND
         IF (YPOS(ISET).LT.YSURMN) THEN
           XSURMN= XPOS(ISET)
           YSURMN= YPOS(ISET)
         ENDIF
C
 1100   CONTINUE
C
      ENDIF
C
C          TEST TO SEE IF THE VISIBLE POLYGON IS COMPLETELY
C          ABOVE THE MAXIMUM CONTOUR INTERSECTION.
C
      IF (INT(SIGN(1.0,(YMIN-YINT(1,1))*(XINT(2,1)-XINT(1,1))-
     &             (XMIN-XINT(1,1))*(YINT(2,1)-YINT(1,1)))).EQ.
     &    INT(SIGN(1.0,(YSURMN-YINT(1,1))*(XINT(2,1)-XINT(1,1))-
     &             (XSURMN-XINT(1,1))*(YINT(2,1)-YINT(1,1))))) THEN
        LEVNUM= ILEVLO
      ELSE
        LEVNUM= ILEVHI
      ENDIF
C
      IF (YSURMN.GE.YINTMX) GO TO 7
C
C          DIVIDE THE VISIBLE POLYGON INTO TRIANGLES.
C
      INDTR= (INDADD+1)/2
      XTRIAN(1)= XADDPT(INDTR)
      YTRIAN(1)= YADDPT(INDTR)
      KNTTRI= INDADD+INDEND-INDST-1
      NPT1= MAX(INDTR-1,0)
      NPT2= INDEND-INDST+1
      NPT3= MAX(INDADD-INDTR,0)
      IND1= INDST
    2 IND= 2
      IF (NPT1+NPT3.EQ.0.AND.NPT2.LE.1) RETURN
      IF (NPT1.NE.0) THEN
        XTRIAN(2)= XADDPT(1)
        YTRIAN(2)= YADDPT(1)
        NPT1= 0
        IND= 3
      ENDIF
C
    3 IF (NPT2.NE.0) THEN
        XTRIAN(IND)= XPOS(IND1)
        YTRIAN(IND)= YPOS(IND1)
        IF (IND.EQ.2) THEN
          NPT2= NPT2-1
          IND1= IND1+1
        ENDIF
C
        IND= IND+1
C
      ENDIF
C
      IF (IND.EQ.4) GO TO 4
      IF (NPT2.NE.0) GO TO 3
C
      XTRIAN(3)= XADDPT(INDADD)
      YTRIAN(3)= YADDPT(INDADD)
      NPT3= 0
C
C          FIND THE DISTANCE OF THE CENTRE OF GRAVITY OF THE
C          TRIANGLE FROM THE MINIMUM HEIGHT POINT ON THE
C          SURROUNDING QUADRILATERAL.
C
    4 XMED= (XTRIAN(1)+XTRIAN(2)+XTRIAN(3))/3.0
      YMED= (YTRIAN(1)+YTRIAN(2)+YTRIAN(3))/3.0
C
C          INTERSECT THE CONTOUR LINES WITH THE TRIANGLE.
C
      INTCNT= 0
      KONTCL= KONKOL(1)
      ITRIAN(1)= 0
      ITRIAN(2)= 0
      ITRIAN(3)= 0
C
      DO 1200 ILEV= 1,NOLEV
C
C          EXTEND THE LINES TO AVOID ROUNDING ERRORS.
C
        XLINE1(1)= XINT(1,ILEV)*2.0-XINT(2,ILEV)
        XLINE1(2)= XINT(2,ILEV)*2.0-XINT(1,ILEV)
        YLINE1(1)= YINT(1,ILEV)*2.0-YINT(2,ILEV)
        YLINE1(2)= YINT(2,ILEV)*2.0-YINT(1,ILEV)
        INTNO= 1
C
        DO 1300 ISET= 1,3
          ISET1= MOD(ISET,3)+1
          IF ((ABS(XINT(1,ILEV)-XTRIAN(ISET)).GE.RMINI.OR.
     &         ABS(YINT(1,ILEV)-YTRIAN(ISET)).GE.RMINI).AND.
     &        (ABS(XINT(2,ILEV)-XTRIAN(ISET)).GE.RMINI.OR.
     &         ABS(YINT(2,ILEV)-YTRIAN(ISET)).GE.RMINI)) THEN
C
C          THE CONTOUR LINE DOES NOT INTERSECT THE
C          START OF THE SIDE OF THE TRIANGLE.
C
            IF ((ABS(XINT(1,ILEV)-XTRIAN(ISET1)).LT.RMINI.AND.
     &           ABS(YINT(1,ILEV)-YTRIAN(ISET1)).LT.RMINI).OR.
     &          (ABS(XINT(2,ILEV)-XTRIAN(ISET1)).LT.RMINI.AND.
     &           ABS(YINT(2,ILEV)-YTRIAN(ISET1)).LT.RMINI)) THEN
              XINTR1(INTNO)= XTRIAN(ISET1)
              YINTR1(INTNO)= YTRIAN(ISET1)
              INTR1(INTNO)= 6-ISET-ISET1
              IF (INTNO.EQ.2) GO TO 5
C
              INTNO= INTNO+1
C
C          THE CONTOUR LINE DOES NOT INTERSECT THE
C          END OF THE SIDE OF THE TRIANGLE.
C
            ELSE
              XLINE2(1)= XTRIAN(ISET)
              YLINE2(1)= YTRIAN(ISET)
              XLINE2(2)= XTRIAN(ISET1)
              YLINE2(2)= YTRIAN(ISET1)
              CALL G0INTR(ICODE,XINTR1(INTNO),YINTR1(INTNO))
              INTR1(INTNO)= 6-ISET-ISET1
              IF (ICODE.NE.0) THEN
                IF (ABS(XINTR1(INTNO)-XTRIAN(ISET)).GE.RMINI.OR.
     &              ABS(YINTR1(INTNO)-YTRIAN(ISET)).GE.RMINI) THEN
                  IF (INTNO.EQ.2) GO TO 5
C
                  INTNO= INTNO+1
                ENDIF
C
              ENDIF
C
            ENDIF
C
          ENDIF
C
 1300   CONTINUE
C
        IF (MODE.EQ.2) GO TO 1200
C
        INTNO= INTNO-1
    5   IF (MODE.EQ.1) THEN
C
C          DETERMINE WHICH SIDE OF THE LINE THE MINIMUM HEIGHT
C          POINT OF THE QUADRILATERAL LIES ON.
C
          MINSGN= SIGN(1.0,(XMIN-XLINE1(1))*(YLINE1(2)-YLINE1(1))-
     &                     (YMIN-YLINE1(1))*(XLINE1(2)-XLINE1(1)))
          IF (INTNO.NE.2) THEN
C
C          THE CONTOUR LINE DID NOT INTERSECT THE TRIANGLE.
C          DETERMINE WHICH SIDE OF THE LINE THE CENTRE OF
C          GRAVITY OF THE TRIANGLE LIES ON.
C
            ICGSGN= SIGN(1.0,(XMED-XLINE1(1))*(YLINE1(2)-YLINE1(1))-
     &                       (YMED-YLINE1(1))*(XLINE1(2)-XLINE1(1)))
            IF (ICGSGN.NE.MINSGN) KONTCL= KONKOL(ILEV+1)
C
C          CHECK TO SEE IF NO CONTOURS INTERSECTED THE TRIANGLE.
C
            IF (INTCNT.EQ.0.AND.ILEV.EQ.NOLEV)
     &         CALL G0SFLP(XTRIAN,YTRIAN,3,KONTCL)
C
          ELSE
C
C          THE CONTOUR INTERSECTS THE TRIANGLE.
C
            INTCNT= INTCNT+1
            IF (INTCNT.EQ.1) THEN
C
C          STARTING TRIANGLE OR QUADRILATERAL.
C
              XSTORE(1)= XINTR1(1)
              YSTORE(1)= YINTR1(1)
              XSTORE(2)= XINTR1(2)
              YSTORE(2)= YINTR1(2)
C
C          DETERMINE WHICH SIDE OF THE LINE THE APEX OF
C          THE TRIANGLE LIES ON.
C
              NC= 6-INTR1(1)-INTR1(2)
              IAPSGN= SIGN(1.0,(XTRIAN(NC)-XLINE1(1))*
     &                         (YLINE1(2)-YLINE1(1))-
     &                         (YTRIAN(NC)-YLINE1(1))*
     &                         (XLINE1(2)-XLINE1(1)))
              IF (IAPSGN.EQ.MINSGN) THEN
                XSTORE(3)= XTRIAN(NC)
                YSTORE(3)= YTRIAN(NC)
                ITRIAN(NC)= 1
                INDSTR= 3
              ELSE
C
                DO 1400 ISET= 1,2
                  NC= MOD(NC,3)+1
                  IF (NC.EQ.INTR1(1)) THEN
                    XSTORE(3)= XTRIAN(NC)
                    YSTORE(3)= YTRIAN(NC)
                  ELSE
                    XSTORE(4)= XTRIAN(NC)
                    YSTORE(4)= YTRIAN(NC)
                  ENDIF
C
                  ITRIAN(NC)= 1
 1400           CONTINUE
C
                INDSTR= 4
              ENDIF
C
              CALL G0SFLP(XSTORE,YSTORE,INDSTR,KONKOL(ILEV))
            ELSE
C
C          INTERMEDIATE QUADRILATERAL OR PENTAGON.
C
              XSTORE(1)= XINTR2(1)
              YSTORE(1)= YINTR2(1)
              XSTORE(2)= XINTR2(2)
              YSTORE(2)= YINTR2(2)
C
              DO 1500 NC= 1,3
                IF (ITRIAN(NC).EQ.0) THEN
                  IAPSGN= SIGN(1.0,(XTRIAN(NC)-XLINE1(1))*
     &                             (YLINE1(2)-YLINE1(1))-
     &                             (YTRIAN(NC)-YLINE1(1))*
     &                             (XLINE1(2)-XLINE1(1)))
                  IF (IAPSGN.EQ.MINSGN) THEN
                    IF (NC.EQ.INTR2(1)) THEN
                      XSTORE(3)= XTRIAN(NC)
                      YSTORE(3)= YTRIAN(NC)
                      IF (NC.EQ.INTR1(2)) THEN
                        XSTORE(4)= XINTR1(1)
                        YSTORE(4)= YINTR1(1)
                        XSTORE(5)= XINTR1(2)
                        YSTORE(5)= YINTR1(2)
                      ELSE
                        XSTORE(4)= XINTR1(2)
                        YSTORE(4)= YINTR1(2)
                        XSTORE(5)= XINTR1(1)
                        YSTORE(5)= YINTR1(1)
                      ENDIF
C
                    ELSE
                      IF (NC.EQ.INTR1(2)) THEN
                        XSTORE(3)= XINTR1(2)
                        YSTORE(3)= YINTR1(2)
                        XSTORE(4)= XINTR1(1)
                        YSTORE(4)= YINTR1(1)
                      ELSE
                        XSTORE(3)= XINTR1(1)
                        YSTORE(3)= YINTR1(1)
                        XSTORE(4)= XINTR1(2)
                        YSTORE(4)= YINTR1(2)
                      ENDIF
C
                      XSTORE(5)= XTRIAN(NC)
                      YSTORE(5)= YTRIAN(NC)
                    ENDIF
C
                    ITRIAN(NC)= 1
                    INDSTR= 5
                    GO TO 6
C
                  ENDIF
                ENDIF
C
 1500         CONTINUE
C
              XSTORE(3)= XINTR1(2)
              YSTORE(3)= YINTR1(2)
              XSTORE(4)= XINTR1(1)
              YSTORE(4)= YINTR1(1)
              INDSTR= 4
    6         CALL G0SFLP(XSTORE,YSTORE,INDSTR,KONKOL(ILEV))
            ENDIF
C
            XINTR2(1)= XINTR1(1)
            YINTR2(1)= YINTR1(1)
            XINTR2(2)= XINTR1(2)
            YINTR2(2)= YINTR1(2)
            INTR2(1)= INTR1(1)
            INTR2(2)= INTR1(2)
            KOLSAV= KONKOL(ILEV+1)
          ENDIF
C
        ELSE
          CALL POSITN(XINTR1(1),YINTR1(1))
          CALL JOIN(XINTR1(2),YINTR1(2))
        ENDIF
C
 1200 CONTINUE
C
      IF (MODE.EQ.2) GO TO 2
C
C          FINAL TRIANGLE OR QUADRILATERAL.
C
      IF (INTCNT.GT.0) THEN
        XSTORE(1)= XINTR2(1)
        YSTORE(1)= YINTR2(1)
        XSTORE(2)= XINTR2(2)
        YSTORE(2)= YINTR2(2)
        INDSTR= 2
C
        DO 1600 NC= 1,3
          IF (ITRIAN(NC).EQ.0) THEN
            IF (NC.NE.INTR2(2)) THEN
              XSTORE(3)= XTRIAN(NC)
              YSTORE(3)= YTRIAN(NC)
              IF (INDSTR.NE.4) INDSTR= 3
            ELSE
              XSTORE(4)= XTRIAN(NC)
              YSTORE(4)= YTRIAN(NC)
              INDSTR= 4
            ENDIF
          ENDIF
C
 1600   CONTINUE
C
        CALL G0SFLP(XSTORE,YSTORE,INDSTR,KOLSAV)
      ENDIF
C
      GO TO 2
C
    7 IF (MODE.EQ.2) RETURN
C
C          NO CONTOURS INTERSECT, SO FILL WHOLE AREA WITH ONE COLOUR.
C
      INDSTR= 0
      IF (INDST.LE.INDEND)THEN
        XSTORE(1)= XPOS(INDST)
        YSTORE(1)= YPOS(INDST)
        INDSTR= 1
        IF (INDST.LT.INDEND) THEN
C
          DO 1700 IND= INDST+1,INDEND
            INDSTR= INDSTR+1
            XSTORE(INDSTR)= XPOS(IND)
            YSTORE(INDSTR)= YPOS(IND)
 1700     CONTINUE
C
        ENDIF
      ENDIF
C
      IF (INDADD.GT.0) THEN
        INDLST= INDADD
        IF (INDSTR.EQ.0) THEN
          XSTORE(1)= XADDPT(INDADD)
          YSTORE(1)= YADDPT(INDADD)
          INDSTR= 1
          INDLST= INDADD-1
        ENDIF
C
        IF (INDLST.GT.0) THEN
C
          DO 1800 IND= INDLST,1,-1
            INDSTR= INDSTR+1
            XSTORE(INDSTR)= XADDPT(IND)
            YSTORE(INDSTR)= YADDPT(IND)
 1800     CONTINUE
C
        ENDIF
      ENDIF
C
      CALL G0SFLP(XSTORE,YSTORE,INDSTR,LEVNUM)
C
      RETURN
      END
