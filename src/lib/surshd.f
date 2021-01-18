      SUBROUTINE SURSHD(SURFAS,ISTRTX,ISTOPX,NPTSX,ISTRTY,ISTOPY,NPTSY)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 350)   VERSION (A9.1)    18:JUL:95
C          ------------------------------------------------
C
C          THIS PLOTS A SURFACE PROJECTION OF THE REGULAR
C          RECTANGULAR GRID OF SPOT HEIGHTS IN SURFAS AND
C          SHADES IT WITH LIGHT FORM A GIVEN DIRECTION
C          USING GIVEN REFLECTIVITY COEFFICIENTS.
C
C
C          THE ARGUMENTS ARE AS FOLLOWS:
C
C          [SURFAS]  IS THE ARRAY OF SURFACE HEIGHT VALUES.
C          <ISTRTX>  IS THE LOWER X-EXTENT,
C          <ISTOPX>  IS THE UPPER X-EXTENT, WHILE
C          <ISTRTY>  AND
C          <ISTOPY>  ARE THE CORRESPONDING Y-BOUNDS.
C          <NPTSX>   IS THE ACTUAL ARRAY X-EXTENT, AND
C          <NPTSY>   IS THE ACTUAL ARRAY Y-EXTENT.
C
C
      REAL    SURFAS(NPTSX,NPTSY),ARG(2)
      LOGICAL ERRON
C
      COMMON /T0ACON/ ANGCON
      COMMON /T0AUTM/ MAPNUM
      COMMON /T0CANG/ STANG0,CRANG0
      COMMON /T0CDIM/ MAGN0,OBLAT0
      COMMON /T0KSYS/ KOLSYS
      COMMON /T0LATT/ KOLIN0,ITHIK0
      COMMON /T0MACT/ MRKMAP,MRKWIN
      COMMON /T0MAPA/ X1MAPV,X2MAPV,Y1MAPV,Y2MAPV
      COMMON /T0PPOS/ XPLOT0,YPLOT0
      COMMON /T0SANG/ TLTANG
      COMMON /T0SBAS/ IUNDRS,INDBAS,BASEHT
      COMMON /T0SCOL/ LINCUP,LINCLW,LINCBS
      COMMON /T0SCOM/ XLEN,YLEN,SCALE,XSHIFT,YSHIFT,SURMIN,SURMAX
      COMMON /T0SDL1/ DELTXR,DELTYR,DELTZR,DELTXC,DELTYC,DELTZC,
     &                VSCALE,ZSCALE,ITPBTM,IQDRNT
      COMMON /T0SKOL/ HUESHD,JKOLS,KOLSTA
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
      COMMON /T0WNDO/ X1WND0,X2WND0,Y1WND0,Y2WND0
      COMMON /T3ERRS/ ERRON,NUMERR
C
      DATA ARG /0.0,1.0/
C
C
      ITRAC1= ISTRTX
      ITRAC2= ISTOPX
      ITRAC3= ISTRTY
      ITRAC4= ISTOPY
      IF (IPRINT.EQ.1) CALL G0MESG(198,8)
C
      ILENX= ISTOPX-ISTRTX
      ILENY= ISTOPY-ISTRTY
      XLEN= ILENX
      YLEN= ILENY
      IF (ISTRTX.LT.1.OR.ISTRTY.LT.1)         GO TO 901
      IF (ILENX.LT.1.OR.ILENX.GT.256)         GO TO 901
      IF (ILENY.LT.1.OR.ILENY.GT.256)         GO TO 901
      IF (ISTOPX.GT.NPTSX.OR.ISTOPY.GT.NPTSY) GO TO 901
      IF (TLTANG.LT.0.0)                      GO TO 902
C
      LINSAV= KOLIN0
      NUMSAV= MAPNUM
      MAGSAV= MAGN0
      STANSV= STANG0
      CRANSV= CRANG0
      OBLSAV= OBLAT0
      CALL CTRANG(0.0)
      CALL CTRORI(0.0)
      CALL CTROBL(1.0)
      IPRSAV= IPRINT
      IPRINT=0
      CALL G0AUTO(ARG,ARG,1,2,1,2,1)
      XPSAV= XPLOT0
      YPSAV= YPLOT0
      X1MSAV= X1MAPV
      X2MSAV= X2MAPV
      Y1MSAV= Y1MAPV
      Y2MSAV= Y2MAPV
      X1WSAV= X1WND0
      X2WSAV= X2WND0
      Y1WSAV= Y1WND0
      Y2WSAV= Y2WND0
      MRKSAV= MRKWIN
      KOLSSV= KOLSYS
      CALL HLS
C
      DO 100 I= 0,JKOLS
        CLR= FLOAT(I)/FLOAT(JKOLS)
        CALL COLSET(HUESHD,CLR,1.0,I+KOLSTA)
  100 CONTINUE
C
      KOLSYS= KOLSSV
      CALL G0SINI(SURFAS,ISTRTX,ISTOPX,NPTSX,ISTRTY,ISTOPY,NPTSY)
C
C          DRAW THE SURFACE
C
      ITPBTM= 1
      CALL LINCOL(LINCUP)
      CALL G0SSHD(SURFAS,ISTRTX,ISTOPX,NPTSX,ISTRTY,ISTOPY,NPTSY)
C
      IF (INDBAS.EQ.1) THEN
        ITPBTM= 0
        CALL G0SSHD(SURFAS,ISTRTX,ISTOPX,NPTSX,ISTRTY,ISTOPY,NPTSY)
      ENDIF
C
C          THE ENTRY STATE IS RESTORED BEFORE ENDING
C
      CALL LINCOL(LINSAV)
      CALL WINFOL
      MAPNUM= NUMSAV
      CALL G0MAPS(X1MSAV,X2MSAV,Y1MSAV,Y2MSAV)
      IF (MRKSAV.NE.0) CALL WINDOW(X1WSAV,X2WSAV,Y1WSAV,Y2WSAV)
C
      CALL POSITN(XPSAV,YPSAV)
      CALL CTRMAG(MAGSAV)
      CALL CTRANG(CRANSV/ANGCON)
      CALL CTRORI(STANSV/ANGCON)
      CALL CTROBL(OBLSAV)
      IPRINT= IPRSAV
      RETURN
C
  901 NUMERR= 40
      IF (ERRON) CALL G0ERMS
      RETURN
C
  902 NUMERR= 60
      IF (ERRON) CALL G0ERMS
      RETURN
C
      END
