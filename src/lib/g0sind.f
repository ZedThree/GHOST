      SUBROUTINE G0SIND(XEND2,XEND4,YEND2,YEND4)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 363)   VERSION (A9.1)    05:MAY:92
C          ------------------------------------------------
C
C          THIS ROUTINE DRAWS THE DIRECTION INDICATOR ON SURFACE PLOTS.
C
      COMMON /T0SCOM/ XLEN,YLEN,SCALE,XSHIFT,YSHIFT,SURMIN,SURMAX
      COMMON /T0SDL1/ DELTXR,DELTYR,DELTZR,DELTXC,DELTYC,DELTZC,
     &                VSCALE,ZSCALE,ITPBTM,IQDRNT
C
      DATA ICIRCL /229/, LETTRX /88/, LETTRY /89/, LETTRZ /90/
C
C
      YSANOT= 0.04
      IF (XSHIFT.GT.0.5) THEN
        XSANOT= 0.05
        IF (XEND2.LT.0.15) YSANOT= MIN(YSANOT,YEND2-0.08)
      ELSE
        XSANOT= 0.95
        IF (XEND4.GT.0.85) YSANOT= MIN(YSANOT,YEND4-0.08)
      ENDIF
C
      ANG1= ATAN2(DELTYR,DELTXR)
      XTRAN1= 0.03*COS(ANG1)
      YTRAN1= 0.03*SIN(ANG1)
      ANG2= ATAN2(DELTYC,DELTXC)
      XTRAN2= 0.03*COS(ANG2)
      YTRAN2= 0.03*SIN(ANG2)
      IF (IQDRNT.EQ.1) THEN
        CALL POSITN(XSANOT+XTRAN1,YSANOT+YTRAN1)
        CALL SPACE(1)
        CALL TYPENC(LETTRX)
        CALL JOIN(XSANOT,YSANOT)
        CALL LINE(XTRAN2,YTRAN2)
        CALL SPACE(-1)
        CALL TYPENC(LETTRY)
      ELSE IF (IQDRNT.EQ.2) THEN
        CALL POSITN(XSANOT+XTRAN2,YSANOT+YTRAN2)
        CALL SPACE(-1)
        CALL TYPENC(LETTRX)
        CALL JOIN(XSANOT,YSANOT)
        CALL LINE(-XTRAN1,-YTRAN1)
        CALL SPACE(-1)
        CALL TYPENC(LETTRY)
      ELSE IF (IQDRNT.EQ.3) THEN
        CALL POSITN(XSANOT-XTRAN1,YSANOT-YTRAN1)
        CALL SPACE(-1)
        CALL TYPENC(LETTRX)
        CALL JOIN(XSANOT,YSANOT)
        CALL LINE(-XTRAN2,-YTRAN2)
        CALL SPACE(1)
        CALL TYPENC(LETTRY)
      ELSE
        CALL POSITN(XSANOT-XTRAN2,YSANOT-YTRAN2)
        CALL SPACE(1)
        CALL TYPENC(LETTRX)
        CALL JOIN(XSANOT,YSANOT)
        CALL LINE(XTRAN1,YTRAN1)
        CALL SPACE(1)
        CALL TYPENC(LETTRY)
      ENDIF
C
      CALL POSITN(XSANOT,YSANOT)
      CALL TYPENC(ICIRCL)
      CALL JOIN(XSANOT,YSANOT+0.03)
      CALL PLOTNC(XSANOT,YSANOT+0.04,LETTRZ)
      RETURN
      END