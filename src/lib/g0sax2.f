      SUBROUTINE G0SAX2(NUMAXE,AXORG,XAX1,YAX1,XSFACT,YSFACT,AXSCAL)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 354)   VERSION (A9.1)    13:MAY:92
C          ------------------------------------------------
C
C          SUPPORT ROUTINE FOR G0SAX1 SURFACE PLOTTING ROUTINE.
C
      REAL    RDATA(1)
      INTEGER IDECFC(3)
C
      COMMON /T0ADIY/ DIVLY,NTIKLY,NTIKHY
      COMMON /T0ANOY/ KANNY,NCHRSY,NAFTPY
      COMMON /T0ASKY/ NSKIPY,NDECSY
      COMMON /T0NOTA/ NOTATA
      COMMON /T0SDL1/ DELTXR,DELTYR,DELTZR,DELTXC,DELTYC,DELTZC,
     &                VSCALE,ZSCALE,ITPBTM,IQDRNT
C
      DATA IDECFC /120,49,48/
C
C
      NOTSAV= NOTATA
      NOTATA= 10
      CALL G0DIVS(2,0.0)
      IF (NTIKHY.LT.NTIKLY) RETURN
      IF ((NUMAXE.EQ.3.OR.NUMAXE.EQ.4).AND.DIVLY.LT.1.0) THEN
        NTIKLY= NINT(NTIKLY*DIVLY)
        NTIKHY= NINT(NTIKHY*DIVLY)
        DIVLY= 1.0
        KANNY= KANNY-1
      ENDIF
C
      FACTOR= 10.0**(-NDECSY)
      AXSCY1= AXSCAL*DELTYC/DELTXC
      ANG1= ATAN2(DELTYR,DELTXR)
      CSANG1= COS(ANG1)
      SNANG1= SIN(ANG1)
      AXSCY2= AXSCAL*DELTYR/DELTXR
      ANG2= ATAN2(DELTYC,DELTXC)
      CSANG2= COS(ANG2)
      SNANG2= SIN(ANG2)
C
      DO 100 ITICK= NTIKLY,NTIKHY
        VALUE= DIVLY*ITICK
        IF (NUMAXE.EQ.1.OR.NUMAXE.EQ.3) THEN
          XPOS= (AXORG-VALUE)*AXSCAL+XAX1
          YPOS= (AXORG-VALUE)*AXSCY1+YAX1
          CALL POSITN(XPOS,YPOS)
          CALL JOIN(XPOS-0.02*CSANG1,YPOS-0.02*SNANG1)
          CALL SPACE(-NCHRSY+1)
        ELSE IF (NUMAXE.EQ.2.OR.NUMAXE.EQ.4) THEN
          XPOS= (VALUE-AXORG)*AXSCAL+XAX1
          YPOS= (VALUE-AXORG)*AXSCY2+YAX1
          CALL POSITN(XPOS,YPOS)
          CALL JOIN(XPOS-0.02*CSANG2,YPOS-0.02*SNANG2)
C         IF (VALUE.LT.0.0) CALL SPACE(2)
C         IF (VALUE.GE.0.0) CALL SPACE(1)
        ELSE
          YPOS= (VALUE-AXORG)*AXSCAL+YAX1
          CALL POSITN(XAX1,YPOS)
          IF (NUMAXE.EQ.5) THEN
            CALL JOIN(XAX1-0.02,YPOS)
            CALL SPACE(-NCHRSY-1)
          ELSE
            CALL JOIN(XAX1+0.02,YPOS)
            CALL SPACE(1)
          ENDIF
        ENDIF
C
        IF (KANNY.GT.2) VALUE= FACTOR*VALUE
        IF (KANNY.EQ.1.OR.KANNY.EQ.3) THEN
          IVALUE= VALUE+SIGN(0.5,VALUE)
          CALL TYPENI(IVALUE)
        ELSE
          CALL TYPENF(VALUE,NAFTPY)
        ENDIF
C
  100 CONTINUE
C
      IF (KANNY.GE.3) THEN
        CALL POSITN(XSFACT,YSFACT)
        CALL G3LINK(2,11,-3,IDECFC,RDATA)
        CALL SUPFIX
        IF (NDECSY.GE.0) CALL SPACE(-1)
C
        CALL TYPENI(NDECSY)
        CALL NORMAL
        NOTATA= NOTSAV
      ENDIF
C
      RETURN
      END
