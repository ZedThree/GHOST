      SUBROUTINE G0SSHD(SURFAS,ISTRTX,ISTOPX,NPTSX,
     &                  ISTRTY,ISTOPY,NPTSY)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 367)   VERSION (A9.1)    13:JAN:94
C          ------------------------------------------------
C
      PARAMETER (ISZARR= 1200, JSZARR= 600)
      REAL    SURFAS(NPTSX,NPTSY),XPOS(JSZARR),YPOS(JSZARR),
     &        RDATA(1),XADDPT(3),YADDPT(3),SXPT(4),SYPT(4),SZPT(4)
      INTEGER IPTRS(JSZARR),IDATA(1)
      LOGICAL ERRON
C
      COMMON /T0INTS/ XLINE1(2),YLINE1(2),XLINE2(2),YLINE2(2)
      COMMON /T0SAN1/ SINAZA,COSAZA,SINTLT,COSTLT
      COMMON /T0SAXE/ INDAXE,XAXORG,YAXORG,XAXDEL,YAXDEL
      COMMON /T0SCHN/ LSTFRE(ISZARR),IFPNTR(ISZARR),IBPNTR(ISZARR),
     &                SXPOS(ISZARR),SYPOS(ISZARR),ISPNTR
      COMMON /T0SCOM/ XLEN,YLEN,SCALE,XSHIFT,YSHIFT,SURMIN,SURMAX
      COMMON /T0SDL1/ DELTXR,DELTYR,DELTZR,DELTXC,DELTYC,DELTZC,
     &                VSCALE,ZSCALE,ITPBTM,IQDRNT
      COMMON /T0SIND/ ISURIN
      COMMON /T0SKOL/ HUESHD,JKOLS,KOLSTA
      COMMON /T0SLIT/ ALIGHT,BLIGHT,CLIGHT
      COMMON /T0SREF/ AMBINT,DIFFUS,SPECT
      COMMON /T3ERRS/ ERRON,NUMERR
C
      DATA RDATA /0.0/
C
C
C          INITIALISE THE CHAINED LIST
C
      DO 100 ISET= 1,ISZARR
        LSTFRE(ISET)= 0
        IFPNTR(ISET)= 0
        IBPNTR(ISET)= 0
  100 CONTINUE
C
      LSTFRE(1)= 1
      ISPNTR= 1
      INDC= -1
      IF (IQDRNT.EQ.1) THEN
        ISTRTA= ISTRTX
        ISTOPA= ISTOPX
        INCA= 1
        ISTRTB= ISTRTY
        ISTOPB= ISTOPY
        SHPOS= MAX(MIN(SURFAS(ISTRTA,ISTRTB),SURMAX),SURMIN)
        INCB= 1
        IDIR= 0
      ELSE IF (IQDRNT.EQ.2) THEN
        ISTRTA= ISTOPY
        ISTOPA= ISTRTY
        INCA= -1
        ISTRTB= ISTRTX
        ISTOPB= ISTOPX
        SHPOS= MAX(MIN(SURFAS(ISTRTB,ISTRTA),SURMAX),SURMIN)
        INCB= 1
        IDIR= 1
      ELSE IF (IQDRNT.EQ.3) THEN
        ISTRTA= ISTOPX
        ISTOPA= ISTRTX
        INCA= -1
        ISTRTB= ISTOPY
        ISTOPB= ISTRTY
        SHPOS= MAX(MIN(SURFAS(ISTRTA,ISTRTB),SURMAX),SURMIN)
        INCB= -1
        IDIR= 0
      ELSE
        ISTRTA= ISTRTY
        ISTOPA= ISTOPY
        INCA= 1
        ISTRTB= ISTOPX
        ISTOPB= ISTRTX
        SHPOS= MAX(MIN(SURFAS(ISTRTB,ISTRTA),SURMAX),SURMIN)
        INCB= -1
        IDIR= 1
      ENDIF
C
      SXPOS(1)= XSHIFT
      SYPOS(1)= VSCALE*SHPOS+YSHIFT
C
      DO 200 JJ= ISTRTB,ISTOPB-INCB,INCB
        INDC= INDC+1
        INDC1= INDC+1
        INDR= -1
        IF (IDIR.EQ.0) THEN
          SHPOS1= MAX(MIN(SURFAS(ISTRTA,JJ),SURMAX),SURMIN)
          SHPOS2= MAX(MIN(SURFAS(ISTRTA,JJ+INCB),SURMAX),SURMIN)
        ELSE
          SHPOS1= MAX(MIN(SURFAS(JJ,ISTRTA),SURMAX),SURMIN)
          SHPOS2= MAX(MIN(SURFAS(JJ+INCB,ISTRTA),SURMAX),SURMIN)
        ENDIF
C
        SXPOS1= INDC*DELTXC+XSHIFT
        SYPOS1= INDC*DELTYC+VSCALE*SHPOS1+YSHIFT
        SZPT(1)= INDC*DELTZC-ZSCALE*SHPOS1
        SXPOS2= INDC1*DELTXC+XSHIFT
        SYPOS2= INDC1*DELTYC+VSCALE*SHPOS2+YSHIFT
        SZPT(2)= INDC1*DELTZC-ZSCALE*SHPOS2
C
        DO 200 II= ISTRTA,ISTOPA-INCA,INCA
          INDR= INDR+1
          INDR1= INDR+1
          IF (IDIR.EQ.0) THEN
            SHPOS3= MAX(MIN(SURFAS(II+INCA,JJ+INCB),SURMAX),SURMIN)
            SHPOS4= MAX(MIN(SURFAS(II+INCA,JJ),SURMAX),SURMIN)
          ELSE
            SHPOS3= MAX(MIN(SURFAS(JJ+INCB,II+INCA),SURMAX),SURMIN)
            SHPOS4= MAX(MIN(SURFAS(JJ,II+INCA),SURMAX),SURMIN)
          ENDIF
C
          SXPOS3= INDR1*DELTXR+INDC1*DELTXC+XSHIFT
          SYPOS3= INDR1*DELTYR+INDC1*DELTYC+VSCALE*SHPOS3+YSHIFT
          SZPT(3)= INDR1*DELTZR+INDC1*DELTZC-ZSCALE*SHPOS3
          SXPOS4= INDR1*DELTXR+INDC*DELTXC+XSHIFT
          SYPOS4= INDR1*DELTYR+INDC*DELTYC+VSCALE*SHPOS4+YSHIFT
          SZPT(4)= INDR1*DELTZR+INDC*DELTZC-ZSCALE*SHPOS4
C
          IF (ITPBTM.EQ.0) GO TO 13
          IF (INDR1.EQ.1) CALL G0SADD(SXPOS2,SYPOS2)
          IF (INDC.EQ.0) CALL G0SADD(SXPOS4,SYPOS4)
C
          SXPT(1)= SXPOS1
          SXPT(2)= SXPOS2
          SXPT(3)= SXPOS3
          SXPT(4)= SXPOS4
          SYPT(1)= SYPOS1
          SYPT(2)= SYPOS2
          SYPT(3)= SYPOS3
          SYPT(4)= SYPOS4
C
C          ASSEMBLE THE POLYLINE DEFINING THE TOP
C          OF THE VISIBLE REGION.
C
          CALL G0SCPT(SXPOS2,IFSTPT)
          NXTPOI= ISPNTR
          IF (IFSTPT.NE.0) NXTPOI= IFPNTR(IFSTPT)
C
          XPOS(1)= SXPOS(IFSTPT)
          YPOS(1)= SYPOS(IFSTPT)
          IPTRS(1)= IFSTPT
          XPOS(2)= SXPOS(NXTPOI)
          YPOS(2)= SYPOS(NXTPOI)
          IPTRS(2)= NXTPOI
          LSTSIZ= 2
          INDEX3= 1
          IF (XPOS(2).LE.SXPOS3) INDEX3= 2
C
          CALL G0SCPT(SXPOS4,LSTPNT)
          IF (SXPOS4.GT.SXPOS(LSTPNT)) LSTPNT= IFPNTR(LSTPNT)
    1     IF (NXTPOI.EQ.LSTPNT) GO TO 2
C
          LSTSIZ= LSTSIZ+1
          IF (LSTSIZ.GT.JSZARR) GO TO 901
C
          NXTPOI= IFPNTR(NXTPOI)
          XPOS(LSTSIZ)= SXPOS(NXTPOI)
          IF (XPOS(LSTSIZ).LE.SXPOS3) INDEX3= LSTSIZ
C
          YPOS(LSTSIZ)= SYPOS(NXTPOI)
          IPTRS(LSTSIZ)= NXTPOI
          GO TO 1
C
    2     INDEX2= INDEX3
          IF (XPOS(INDEX3).LT.SXPOS3) INDEX2= INDEX2+1
C
          LFLAG= 0
C
C          CHECK THE VISIBILITY OF THE LINE END POINTS.
C          SET 'IVIS' TO -1 IF THE POINT IS INVISIBLE,
C                         0 FOR COINCIDENCE AND
C                         1 IF THE POINT IS VISIBLE.
C
C          IVIS AND IVIS1 CAN EACH TAKE ONE OF THREE VALUES.
C          THEREFORE THERE ARE NINE COMBINATIONS OR CASES.
C
C          CASE     IVIS     IVIS1   IVIS+IVIS1
C
C            1       -1       -1         -2
C            2       -1        0         -1
C            3       -1        1          0
C            4        0       -1         -1
C            5        0        0          0
C            6        0        1          1
C            7        1       -1          0
C            8        1        0          1
C            9        1        1          2
C
          YVAL= (SXPOS2-XPOS(1))*(YPOS(2)-YPOS(1))/
     &          (XPOS(2)-XPOS(1))+YPOS(1)
          IVIS2= 0
          IF (SYPOS2.GT.YVAL) IVIS2= 1
          IF (SYPOS2.LT.YVAL) IVIS2= -1
C
          YVAL= (SXPOS3-XPOS(INDEX3))*(YPOS(INDEX3+1)-YPOS(INDEX3))/
     &          (XPOS(INDEX3+1)-XPOS(INDEX3))+YPOS(INDEX3)
          IVIS3= 0
          IF (SYPOS3.GT.YVAL) IVIS3= 1
          IF (SYPOS3.LT.YVAL) IVIS3= -1
C
          YVAL= (SXPOS4-XPOS(LSTSIZ-1))*(YPOS(LSTSIZ)-YPOS(LSTSIZ-1))/
     &          (XPOS(LSTSIZ)-XPOS(LSTSIZ-1))+YPOS(LSTSIZ-1)
          IVIS4= 0
          IF (SYPOS4.GT.YVAL) IVIS4= 1
          IF (SYPOS4.LT.YVAL) IVIS4= -1
C
C          PROCESS THE FIRST LINE SECTION.
C
          XINT1= SXPOS2
          YINT1= SYPOS2
          INDADD= 0
          INDST= 1
          IVISL= IVIS2
          IVIS= -IVIS2
          IND= 1
    3     IND= IND+1
          IF (IND.GT.INDEX2) GO TO 7
C
          YVAL= (XPOS(IND)-SXPOS2)*(SYPOS3-SYPOS2)/
     &          (SXPOS3-SXPOS2)+SYPOS2
          IVIS1= 0
          IF (YPOS(IND).GT.YVAL) IVIS1= 1
          IF (YPOS(IND).LT.YVAL) IVIS1= -1
          IF (IND.EQ.INDEX2) IVIS1= -IVIS3
          IF (IVIS.EQ.0) GO TO 6
          IF (IVIS+IVIS1.NE.0) GO TO 4
C
C          CASES 3 AND 7
C
C          FIND INTERSECTION ON LINE IND-1 TO IND
C
          XLINE1(1)= XINT1
          YLINE1(1)= YINT1
          XLINE1(2)= SXPOS3
          YLINE1(2)= SYPOS3
          XLINE2(1)= XPOS(IND-1)
          YLINE2(1)= YPOS(IND-1)
          XLINE2(2)= XPOS(IND)
          YLINE2(2)= YPOS(IND)
          CALL G0INTR(ICODE,XINT2,YINT2)
          INDADD= INDADD+1
          XADDPT(INDADD)= XINT2
          YADDPT(INDADD)= YINT2
          XINT1= XINT2
          YINT1= YINT2
          IF (IVIS.NE.1) THEN
C
C          CASE 3
C
            CALL G0SHAD(XPOS,YPOS,INDST,IND-1,XADDPT,YADDPT,INDADD,
     &                  SXPT,SYPT,SZPT)
C
            INDADD= 0
            CALL G0SDEL(IPTRS(IND-1))
          ELSE
C
C          CASE7
C
            INDST= IND
          ENDIF
C
          GO TO 5
C
C          CASES 1, 2, 8 AND 9
C
    4     IF (IVIS.LT.0.AND.XPOS(IND).LE.SXPOS3)
C
C          CASES 1 AND 2
C
     &        CALL G0SDEL(IPTRS(IND-1))
          IF (IVIS1.NE.0) GO TO 6
C
C          CASES 2 AND 8
C
          IF (IVIS.NE.1) THEN
C
C          CASE 2
C
            CALL G0SHAD(XPOS,YPOS,INDST,IND,XADDPT,YADDPT,INDADD,
     &                  SXPT,SYPT,SZPT)
C
            INDADD= 0
          ENDIF
C
C          CASES 2 AND 8
C
          INDST= IND
          XINT1= XPOS(IND)
          YINT1= YPOS(IND)
C
C          CASES 2, 3, 7 AND 8
C
    5     CALL G0SADD(XINT1,YINT1)
C
C          ALL CASES
C
    6     IVISL= -IVIS1
          IVISAV= IVIS
          IVIS= IVIS1
          GO TO 3
C
    7     IF (IVISL+IVIS3.GT.0) THEN
            IF (IVISAV.GE.0.AND.INDEX2.GT.INDEX3) LFLAG= 1
C
            INDADD= INDADD+1
            XADDPT(INDADD)= SXPOS3
            YADDPT(INDADD)= SYPOS3
            CALL G0SADD(SXPOS3,SYPOS3)
          ENDIF
C
C          PROCESS THE SECOND LINE SECTION.
C
          XINT1= SXPOS3
          YINT1= SYPOS3
          IVISL= IVIS3
          IVIS= -IVIS3
          IND= INDEX3
    8     IND= IND+1
          IF (IND.GT.LSTSIZ) GO TO 12
C
          YVAL= (XPOS(IND)-SXPOS3)*(SYPOS4-SYPOS3)/
     &          (SXPOS4-SXPOS3)+SYPOS3
          IVIS1= 0
          IF (YPOS(IND).GT.YVAL) IVIS1= 1
          IF (YPOS(IND).LT.YVAL) IVIS1= -1
          IF (IND.EQ.LSTSIZ) IVIS1= -IVIS4
          IF (IVIS.EQ.0) GO TO 11
          IF (IVIS+IVIS1.NE.0) GO TO 9
C
C          CASES 3 AND 7
C
C          FIND INTERSECTION ON LINE IND-1 TO IND
C
          XLINE1(1)= XINT1
          YLINE1(1)= YINT1
          XLINE1(2)= SXPOS4
          YLINE1(2)= SYPOS4
          XLINE2(1)= XPOS(IND-1)
          YLINE2(1)= YPOS(IND-1)
          XLINE2(2)= XPOS(IND)
          YLINE2(2)= YPOS(IND)
          CALL G0INTR(ICODE,XINT2,YINT2)
          INDADD= INDADD+1
          XADDPT(INDADD)= XINT2
          YADDPT(INDADD)= YINT2
          XINT1= XINT2
          YINT1= YINT2
          IF (IVIS.NE.1) THEN
C
C          CASE 3
C
            CALL G0SHAD(XPOS,YPOS,INDST,IND-1,XADDPT,YADDPT,INDADD,
     &                  SXPT,SYPT,SZPT)
C
            INDADD= 0
            IF (LFLAG.EQ.0)
     &          CALL G0SDEL(IPTRS(IND-1))
C
            LFLAG= 0
          ELSE
C
C          CASE7
C
            INDST= IND
          ENDIF
C
          GO TO 10
C
C          CASES 1, 2, 8 AND 9
C
    9     IF (IVIS.LT.0.AND.LFLAG.EQ.0)
C
C          CASES 1 AND 2
C
     &         CALL G0SDEL(IPTRS(IND-1))
C
          LFLAG= 0
          IF (IVIS1.NE.0) GO TO 11
C
C          CASES 2 AND 8
C
          IF (IVIS.NE.1) THEN
C
C          CASE 2
C
            CALL G0SHAD(XPOS,YPOS,INDST,IND,XADDPT,YADDPT,INDADD,
     &                  SXPT,SYPT,SZPT)
C
            INDADD= 0
          ENDIF
C
C          CASES 2 AND 8
C
          INDST= IND
          XINT1= XPOS(IND)
          YINT1= YPOS(IND)
C
C          CASES 2, 3, 7 AND 8
C
   10     CALL G0SADD(XINT1,YINT1)
C
C          ALL CASES
C
   11     IVISL= -IVIS1
          IVIS= IVIS1
          GO TO 8
C
   12     IF (IVISL.EQ.0) CALL G0SDEL(IPTRS(LSTSIZ))
C
          GO TO 14
C
C          FILL THE BASE.
C
   13     IF (INDC.EQ.0) THEN
            YBAS1= INDR*DELTYR+VSCALE*SURMIN+YSHIFT
            YBAS4= YBAS1+DELTYR
            IDATA(1)= 0
            CALL G3LINK(5,13,-1,IDATA,RDATA)
            PRODNL= SINAZA*ALIGHT-COSAZA*SINTLT*BLIGHT-
     &              COSAZA*COSTLT*CLIGHT
            PROD= AMBINT+DIFFUS*MIN(MAX(PRODNL,0.0),1.0)
            IDATA(1)= NINT(PROD*JKOLS)+KOLSTA
            CALL G3LINK(5,3,-1,IDATA,RDATA)
            CALL POSITN(SXPOS1,SYPOS1)
            CALL JOIN(SXPOS1,YBAS1)
            CALL JOIN(SXPOS4,YBAS4)
            CALL JOIN(SXPOS4,SYPOS4)
            CALL JOIN(SXPOS1,SYPOS1)
            CALL G3LINK(5,4,0,IDATA,RDATA)
          ENDIF
C
          IF (INDR.EQ.0) THEN
            YBAS1= INDC*DELTYC+VSCALE*SURMIN+YSHIFT
            YBAS2= YBAS1+DELTYC
            IDATA(1)= 0
            CALL G3LINK(5,13,-1,IDATA,RDATA)
            PRODNL= -COSAZA*ALIGHT-SINAZA*SINTLT*BLIGHT-
     &              SINAZA*COSTLT*CLIGHT
            PROD= AMBINT+DIFFUS*MIN(MAX(PRODNL,0.0),1.0)
            IDATA(1)= NINT(PROD*JKOLS)+KOLSTA
            CALL G3LINK(5,3,-1,IDATA,RDATA)
            CALL POSITN(SXPOS1,SYPOS1)
            CALL JOIN(SXPOS1,YBAS1)
            CALL JOIN(SXPOS2,YBAS2)
            CALL JOIN(SXPOS2,SYPOS2)
            CALL JOIN(SXPOS1,SYPOS1)
            CALL G3LINK(5,4,0,IDATA,RDATA)
          ENDIF
C
  14      SXPOS1= SXPOS4
          SYPOS1= SYPOS4
          SZPT(1)= SZPT(4)
          SXPOS2= SXPOS3
          SYPOS2= SYPOS3
          SZPT(2)= SZPT(3)
  200 CONTINUE
C
      IF (ITPBTM.EQ.0) RETURN
C
      YEND1= VSCALE*SURMIN+YSHIFT
      XEND2= INDC1*DELTXC+XSHIFT
      YEND2= INDC1*DELTYC+VSCALE*SURMIN+YSHIFT
      XEND4= INDR1*DELTXR+XSHIFT
      YEND4= INDR1*DELTYR+VSCALE*SURMIN+YSHIFT
      IF (INDAXE.NE.0) THEN
C
C          DRAW BASE LINES.
C
        CALL POSITN(XEND2,YEND2)
        CALL JOIN(XSHIFT,YEND1)
        CALL JOIN(XEND4,YEND4)
        CALL G0SAX1(ISTRTX,ISTOPX,ISTRTY,ISTOPY,
     &              XEND2,XEND4,YEND1,YEND2,YEND4)
      ENDIF
C
      IF (ISURIN.NE.0) CALL G0SIND(XEND2,XEND4,YEND2,YEND4)
C
      RETURN
C
  901 NUMERR= 41
      IF (ERRON) CALL G0ERMS
      STOP
      END
