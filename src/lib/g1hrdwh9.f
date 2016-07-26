      SUBROUTINE G1HRDW(ICODE)
C
C          ------------------------------------------------
C          ROUTINE NO. (1002)   VERSION (A8.1H9)  21:DEC:93
C          ------------------------------------------------
C
C          THIS SETS HARDWARE-IMPLEMENTED FACILITIES.
C          (THIS VERSION IS FOR HP-GL/2).
C          (THIS IS FOR A SPOOLED OR OFFLINE PLOTTER).
C
C
C          <ICODE> DETERMINES THE HARDWARE FUNCTION REQUIRED:
C
C                  =  0, DEVICE INITIALISATION IS DONE.
C                  =  1, BROKEN LINE TYPE IS SET.
C                  =  2, CHAR. ORENTATION IS SET.
C                  =  3, CHARACTER SIZE IS SET.
C                  =  4, LINE COLOUR NUMBER IS SET.
C                  =  5, PORTRAIT MODE IS SET.
C                  =  6, ITALIC CHARACTERS ARE SET.
C                  =  7, CHARACTER OBLATENESS IS SET.
C                  =  8, A COLOUR TABLE ENTRY IS SET.
C                  =  .
C                  = 11, A POLYGONAL BOUNDARY IS BEGUN.
C                  = 12, A POLYGONAL AREA IS FILLED.
C                  = 13, SHADING OPTION FLAG IS RESET.
C
C
      INTEGER IDUMMY(1),ISCALE(18),KOLTAB(87),
     &        IEXT(2),IBYTE(5),IPA(6),IPLON(24),ISTART(2)
      LOGICAL KHRDW1,LHRDW1
C
      COMMON /T1CANU/ STANGU,CRANGU
      COMMON /T1CATT/ IUNDL1,ITAL1
      COMMON /T1CDIM/ MAGN1,OBLAT1
      COMMON /T1CMLN/ NMFILE(32),LNFILE,ICMND(35,2)
      COMMON /T1DLIM/ DLIMX,DLIMY
      COMMON /T1DRES/ DRESX,DRESY
      COMMON /T1FLTY/ IFLTY1,IFLRP1
      COMMON /T1H9BB/ IHIGHT,ZOBLAT,CHRANG,ISLANT,KOLOUR,KOLNUM,
     &                INTRED,IXCHDS,IYCHDS,IXCHMV,IYCHMV
      COMMON /T1HRDC/ KHRDW1
      COMMON /T1HRDL/ LHRDW1
      COMMON /T1KDEF/ KOLLID,KOLBAD,MAXCLS
      COMMON /T1KFIL/ KOLFL1
      COMMON /T1KTAB/ REDCO1(255),GRNCO1(255),BLUCO1(255),NCOLS1
      COMMON /T1LATT/ KOLIN1,ITHIK1
      COMMON /T1LPAT/ MARKA1,MISSA1,MARKB1,MISSB1
      COMMON /T3CONS/ PI
C
C          ARRAYS ARE INITIALISED TO:
C
C  ISCALE  ; S C 0 , NUL NUL NUL NUL NUL NUL NUL NUL NUL NUL NUL NUL NUL
C  IPA     ; P A 0 , 0
C  ISTART  P R
C  IPLON   ESC % - 1 B B P I N ; W U 1 ; P W 0 . 0 6 ; S P 1
C  KOLTAB  ; N P 2 5 6
C          P C 1 , 0 , 0 , 0
C          P C 2 , 2 5 5 , 0 , 0
C          P C 3 , 0 , 2 5 5 , 0
C          P C 4 , 0 , 0 , 2 5 5
C          P C 5 , 0 , 2 5 5 , 2 5 5
C          P C 6 , 2 5 5 , 0 , 2 5 5
C          P C 7 , 2 5 5 , 2 5 5 , 0
C
      DATA IDUMMY /1/, ICOMMA /44/, IZERO /48/,
     &     ISCALE /59,83,67,48,44,0,0,0,0,0,0,0,0,0,0,0,0,0/,
     &     IPA /59,80,65,48,44,48/, ISTART /80,82/
      DATA IPLON  /27,37,45,49,66,66,80,73,78,59,87,85,49,59,
     &             80,87,48,46,48,54,59,83,80,49/
      DATA KOLTAB /59,78,80,50,53,54,
     &             80,67,49,44,48,44,48,44,48,
     &             80,67,50,44,50,53,53,44,48,44,48,
     &             80,67,51,44,48,44,50,53,53,44,48,
     &             80,67,52,44,48,44,48,44,50,53,53,
     &             80,67,53,44,48,44,50,53,53,44,50,53,53,
     &             80,67,54,44,50,53,53,44,48,44,50,53,53,
     &             80,67,55,44,50,53,53,44,50,53,53,44,48/
C
C
      IF (ICODE.LT.0.OR.ICODE.GT.13) RETURN
      IF (ICODE.NE.0) GO TO 2
C
C          THIS SECTION DOES DEVICE INITIALISATION.
C
      CALL G1CMLN
      CALL G1DVIO(1,IDUMMY,1)
      CALL G1BUFF(ISTART,2)
      CALL G1DVIO(3,IPLON,24)
      CALL G1DVIO(3,KOLTAB,87)
C
C          THE VALUES OF P1X, P1Y, P2X AND P2Y ARE OBTAINED FROM
C          THE PLOTTER MANUAL.  A SELECTION OF VALUES FOLLOWS.
C
C          PLOTTER         MEDIA SIZE       P2X      P2Y
C
C          LASERJET III    LETTER VER       10837     8297
C                          LETTER HOR        8297    10837
C                          LEGAL VER        13885     8297
C                          LEGAL HOR         8297    13885
C                          EXECUTIVE VER    10329     7027
C                          EXECUTIVE HOR     7027    10329
C                          A4 VER           11538     8060
C                          A4 HOR            8060    11538
C          PAINTJET XL     A VER            10894     8303
C                          B VER            16871    10832
C                          A4 VER           11594     8122
C                          A3 VER           16397    11193
C          7600 SERIES     D                34544    22352
C                          E                44704    34544
C          DRAFTMASTER     A VER            8936      7356  NORMAL
C                          A HOR            9896      6396  NORMAL
C                          B VER           15032      9896  NORMAL
C                          C HOR           21072     15032  NORMAL
C                          D VER           32304     21072  NORMAL
C                          D HOR           33264     20112  NORMAL
C                          E VER           42464     33264  NORMAL
C                          ARC C HOR       23104     16048  NORMAL
C                          ARC D VER       34336     23104  NORMAL
C                          ARC D HOR       35296     22144  NORMAL
C                          ARC 30X42 VER   40432     29200  NORMAL
C                          ARC 30X42 HOR   41392     28240  NORMAL
C                          ARC E VER       46528     35296  NORMAL
C                          A4 VER           9640      7120  NORMAL
C                          A4 HOR          10600      6160  NORMAL
C                          A3 VER          14560     10600  NORMAL
C                          A2 HOR          22480     14560  NORMAL
C                          A1 VER          31400     22480  NORMAL
C                          A1 HOR          32360     21520  NORMAL
C                          A0 VER          45320     32360  NORMAL
C                          A VER            9736      8236  EXPANDED
C                          A HOR           10776      7196  EXPANDED
C                          B VER           15832     10776  EXPANDED
C                          C HOR           21952     15832  EXPANDED
C                          D VER           33104     21952  EXPANDED
C                          D HOR           34144     20912  EXPANDED
C                          E VER           43264     34144  EXPANDED
C                          ARC C HOR       23984     16848  EXPANDED
C                          ARC D VER       35136     23984  EXPANDED
C                          ARC D HOR       36176     22944  EXPANDED
C                          ARC 30X42 VER   41232     30080  EXPANDED
C                          ARC 30X42 HOR   42272     29040  EXPANDED
C                          ARC E VER       43264     33128  EXPANDED
C                          A4 VER          10440      8000  EXPANDED
C                          A4 HOR          11480      6960  EXPANDED
C                          A3 VER          15360     11480  EXPANDED
C                          A2 HOR          23360     15360  EXPANDED
C                          A1 VER          32200     23360  EXPANDED
C                          A1 HOR          33240     22320  EXPANDED
C                          A0 VER          46120     33240  EXPANDED
C
C          THE PARAMETERS ARE SET FOR THE PAINTJET XL IN A4 FORMAT.
C
      P1X= 0
      P1Y= 0
      P2X= 11594
      P2Y= 8122
      IXEXT= P2X-P1X
      IYEXT= P2Y-P1Y
      DLIMX= AMAX1(1.0,FLOAT(IXEXT)/FLOAT(IYEXT))
      DLIMY= AMAX1(1.0,FLOAT(IYEXT)/FLOAT(IXEXT))
      DRESX= AMIN0(IXEXT,IYEXT)
      DRESY= DRESX
      IEXT(1)= IXEXT
      IEXT(2)= IYEXT
      INDEX= 5
C
      DO 100 IVAR= 1,2
        DO 200 IND= 1,5
          IDIVSN= IEXT(IVAR)/10
          IBYTE(IND)= IEXT(IVAR)-IDIVSN*10
          INDXBT= IND
          IEXT(IVAR)= IDIVSN
          IF (IDIVSN.EQ.0) GO TO 1
  200   CONTINUE
C
    1   DO 300 IND= 1,INDXBT
          IPOS1= INDEX+IND
          IPOS2= INDXBT-IND+1
          ISCALE(IPOS1)= IBYTE(IPOS2)+IZERO
  300   CONTINUE
C
        INDEX= INDEX+INDXBT
        IF (IVAR.EQ.2) GO TO 100
C
        ISCALE(INDEX+1)= ICOMMA
        ISCALE(INDEX+2)= IZERO
        ISCALE(INDEX+3)= ICOMMA
        INDEX= INDEX+3
  100 CONTINUE
C
      CALL G1BUFF(ISCALE,INDEX)
      CALL G1BUFF(IPA,6)
      IHIGHT= (INT(DRESY)*MAGN1+500)/1000
      IXCHDS= IHIGHT*0.285714
      IYCHDS= IHIGHT*0.285714
      IXCHMV= IHIGHT*0.857143
      IYCHMV= 0
      IF (ICMND(3,1).EQ.1) GO TO 15
C
      RETURN
C
C          THIS SECTION SETS THE MOST APPROPRIATE
C          HARDWARE LINE TYPE FOR THE GIVEN ARGUMENTS.
C
    2 IF (ICODE.NE.1) GO TO 11
      IF (LHRDW1) GO TO 3
C
      LHDEF= 0
      GO TO 10
C
    3 IF (MARKA1.NE.0) GO TO 4
      IF (MISSA1.NE.0) GO TO 4
      IF (MARKB1.NE.0) GO TO 4
      IF (MISSB1.NE.0) GO TO 4
C
      LHDEF= 0
      GO TO 10
C
    4 IF (MARKA1.NE.MARKB1) GO TO 7
      IF (MARKA1*3.GT.MISSA1) GO TO 5
C
      LHDEF= 1
      GO TO 10
C
    5 IF (MARKA1.GT.MISSA1) GO TO 6
C
      LHDEF= 2
      GO TO 10
C
    6 LHDEF= 3
      GO TO 10
C
    7 IF (MARKB1*10.GT.MARKA1) GO TO 8
C
      LHDEF= 4
      GO TO 10
C
    8 IF (MARKB1*3.GT.MARKA1) GO TO 9
C
      LHDEF= 5
      GO TO 10
C
    9 LHDEF= 6
   10 LHMULT= MARKA1+MISSA1+MARKB1+MISSB1
      IF (LHDEF.LT.4) LHMULT= LHMULT/2
C
      CALL G1FILB(0,0,-42,-1)
      CALL G1FILB(0,0,LHDEF,LHMULT)
      RETURN
C
C          THIS SECTION SETS HARDWARE CHAR. ROTATION.
C
   11 IF (ICODE.NE.2) GO TO 12
      IF (.NOT.KHRDW1) RETURN
C
      KHAR= CRANGU*180.0/PI+360.5
      KHAR= MOD(KHAR,360)
      CALL G1FILB(0,0,-12,KHAR)
      RETURN
C
C          THIS SECTION SETS THE CHAR. MAGN. TO THE
C          MOST APPROPRIATE VALUE FOR HARDWARE CHARS.
C
   12 IF (ICODE.NE.3) GO TO 13
      IF (.NOT.KHRDW1) RETURN
C
      KHAR= (MAGN1*INT(DRESY)+500)/1000
      CALL G1FILB(0,0,-11,KHAR)
      RETURN
C
C          THIS SECTION SETS THE LINE COLOUR NUMBER.
C
   13 IF (ICODE.NE.4) GO TO 14
      IF (KOLIN1.GT.MAXCLS) KOLIN1= KOLLID
C
      CALL G1FILB(0,0,-17,KOLIN1)
      RETURN
C
C          THIS SECTION SETS PORTRAIT MODE.
C
   14 IF (ICODE.NE.5) GO TO 16
C
   15 CALL G1FILB(0,0,-21,1)
      RETURN
C
C          THIS SECTION SETS HARDWARE ITALIC.
C
   16 IF (ICODE.NE.6) GO TO 17
      IF (.NOT.KHRDW1) RETURN
C
      CALL G1FILB(0,0,-13,ITAL1)
      RETURN
C
C          THIS SECTION SETS HARDWARE CHARACTER OBLATENESS.
C
   17 IF (ICODE.NE.7) GO TO 18
      IF (.NOT.KHRDW1) RETURN
C
      IOBLAT= OBLAT1*1000.0
      CALL G1FILB(0,0,-14,IOBLAT)
      RETURN
C
C          THIS SECTION SETS A COLOUR TABLE ENTRY.
C
   18 IF (ICODE.NE.8) GO TO 19
      IF (NCOLS1.GT.MAXCLS) RETURN
C
      IRED= NINT(REDCO1(NCOLS1)*255.0)
      IGREEN= NINT(GRNCO1(NCOLS1)*255.0)
      IBLUE= NINT(BLUCO1(NCOLS1)*255.0)
      CALL G1FILB(0,0,-41,-2)
      CALL G1FILB(0,0,NCOLS1,IRED)
      CALL G1FILB(0,0,IGREEN,IBLUE)
      RETURN
C
C          THIS SECTION SETS THE DEVICE RESOLUTION.
C          (IT IS NOT IMPLEMENTED IN THIS VERSION).
C
   19 IF (ICODE.NE.9) GO TO 20
      RETURN
C
C          THIS SECTION SETS THE BACKGROUND COLOUR.
C          (IT IS NOT IMPLEMENTED IN THIS VERSION).
C
   20 IF (ICODE.NE.10) GO TO 21
      RETURN
C
C          THIS SECTION BEGINS A FILL AREA.
C
   21 IF (ICODE.NE.11) GO TO 22
      IF (KOLFL1.GT.MAXCLS) KOLFL1= KOLLID
C
      CALL G1FILB(0,0,-17,KOLFL1)
      RETURN
C
C          THIS SECTION FILLS THE POLYGONAL AREA.
C
   22 IF (ICODE.NE.12) GO TO 23
C
      CALL G1FILB(0,0,-17,KOLIN1)
      RETURN
C
C          THIS SECTION RESETS THE SHADING OPTION FLAG.
C
   23 IFLRP1= 0
      RETURN
      END
