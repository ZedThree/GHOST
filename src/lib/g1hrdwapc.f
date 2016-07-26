      SUBROUTINE G1HRDW(ICODE)
C
C          ------------------------------------------------
C          ROUTINE NO. (1002)   VERSION (A8.1APC) 14:JUL:97
C          ------------------------------------------------
C
C          THIS SETS HARDWARE-IMPLEMENTED FACILITIES.
C          (THIS VERSION IS FOR ADOBE COLOUR POSTSCRIPT).
C
C
C          <ICODE> DETERMINES THE HARDWARE FUNCTION REQUIRED:
C
C                  =  0, DEVICE INITIALISATION IS DONE.
C                  =  1, BROKEN LINE TYPE IS SET.
C                  =  2, CHAR. ORIENTATION IS SET.
C                  =  3, CHARACTER SIZE IS SET.
C                  =  4, LINE COLOUR NUMBER IS SET.
C                  =  5, PORTRAIT MODE IS SET.
C                  =  6, POSTSCRIPT FONT IS SET.
C                  =  7, CHARACTER OBLATENESS IS SET.
C                  =  8, A COLOUR TABLE ENTRY IS SET.
C                  =  .
C                  = 11, A POLYGONAL BOUNDARY IS BEGUN.
C                  = 12, A POLYGONAL AREA IS FILLED.
C                  = 13, SHADING OPTION FLAG IS RESET.
C
C
      INTEGER IDUMMY(1),IPL0(24),IPL1(17),IPL2(23),IPL3(35),IPL4(42),
     &        IPL5(42),IPL6(53),IPL7(62),IPL8(51),IPL9(48),IPLA(51),
     &        IPLB(61),IPLC(54),IPLD(59),IPLE(47),IPLF(50),IPLG(49),
     &        IPLH(55),IPLI(71),IPLJ(43),IPLK(70),IPLL(61),IPLM(58),
     &        IPLN(30),IPLO(12)
      LOGICAL KHRDW1,LHRDW1,CURTRA
C
      COMMON /T1APCB/ CHIGHT,ZOBLAT,IREDPO(255),IGRNPO(255),IBLUPO(255),
     &                KOLOUR,IPAGE(17),IPGCNT,IPBBOX(26),IDBOX(14),
     &                IPBOX(18)
      COMMON /T1CANU/ STANGU,CRANGU
      COMMON /T1CATT/ IUNDL1,ITAL1
      COMMON /T1CDIM/ MAGN1,OBLAT1
      COMMON /T1CFON/ KFONT1
      COMMON /T1CMLN/ NMFILE(32),LNFILE,ICMND(35,2)
      COMMON /T1DRES/ DRESX,DRESY
      COMMON /T1FLTY/ IFLTY1,IFLRP1
      COMMON /T1HRDC/ KHRDW1
      COMMON /T1HRDL/ LHRDW1
      COMMON /T1KDEF/ KOLLID,KOLBAD,MAXCLS
      COMMON /T1KFIL/ KOLFL1
      COMMON /T1KTAB/ REDCO1(255),GRNCO1(255),BLUCO1(255),NCOLS1
      COMMON /T1LATT/ KOLIN1,ITHIK1
      COMMON /T1LPAT/ MARKA1,MISSA1,MARKB1,MISSB1
      COMMON /T1TCOC/ XCCX,XCCY,YCCX,YCCY,RPICXC,RPICYC,RDEVXC,RDEVYC,
     &                CURTRA
      COMMON /T1TRNC/ SCALXC,SCALYC,ROTATC
      COMMON /T1TRNS/ SCALXS,SCALYS,ROTATS,RDEVXS,RDEVYS
      COMMON /T3CONS/ PI
C
C          ARRAYS ARE INITIALISED TO:
C
C   IPL0  %!PS-Adobe-3.0 EPSF-3.0
C   IPL1  %%Creator: GHOST
C   IPL2  %%BoundingBox: (atend)
C   IPL3  /SavedState save def 50 dict begin
C   IPL4  /bd {bind def} bind def /ed {exch def} bd
C   IPL5  /ch 32 def /cw 32 def /cs 0 def /cr 0 def
C   IPL6  /gs {gsave} bd /gr {grestore} bd /C {setrgbcolor} bd
C   IPL7  /m {moveto} bd /l {lineto} bd /M {rmoveto} bd /L {rlineto} bd
C   IPL8  /T {/marked true def} bd /F {/marked false def} bd
C   IPL9  /s {currentpoint stroke T m} bd /n {newpath} bd
C   IPLA  /f {currentpoint fill T m} bd /t {setlinewidth} bd
C   IPLB  /i {0 0 0 C 1 setlinecap 1 setlinejoin 0.24 0.24 scale 75 75
C   IPLC   translate fs F} bd /S {/sv save def i} bd /FontArray
C   IPLD   [/Times-Roman /Times-Italic /Times-Bold /Times-BoldItalic
C   IPLE   /Helvetica /Helvetica-Oblique /Helvetica-Bold
C   IPLF   /Helvetica-BoldOblique /Courier /Courier-Oblique
C   IPLG   /Courier-Bold /Courier-BoldOblique /Symbol] def
C   IPLH  /fs {FontArray cs get findfont 1 scalefont setfont} bd
C   IPLI  /sch {/ch ed} bd /scw {/cw ed} bd /scs {/cs ed fs} bd
C          /scr {/cr ed} bd
C   IPLJ  /c {gs cr rotate cw ch scale show gr T} bd
C   IPLK  /p {marked {showpage} if ch cw cs cr sv restore scr scs scw
C          sch S} bd
C   IPLL  /x {p end SavedState restore} bd /P {s gs 5 t 0 0 L s gr} bd
C   IPLM  /g {currentfile token pop 2.329 mul dup 0 eq {pop} if} bd
C   IPLN  /b {[g g g g] 0 setdash} bd S
C   IPLO  %%EndProlog
C
      DATA IPL0 / 37, 33, 80, 83, 45, 65,100,111, 98,101, 45, 51,
     &            46, 48, 32, 69, 80, 83, 70, 45, 51, 46, 48, 32/
      DATA IPL1 / 37, 37, 67,114,101, 97,116,111,114, 58, 32, 71,
     &            72, 79, 83, 84, 32/
      DATA IPL2 / 37, 37, 66,111,117,110,100,105,110,103, 66,111,
     &           120, 58, 32, 40, 97,116,101,110,100, 41, 32/
      DATA IPL3 / 47, 83, 97,118,101,100, 83,116, 97,116,101, 32,
     &           115, 97,118,101, 32,100,101,102, 32, 53, 48, 32,
     &           100,105, 99,116, 32, 98,101,103,105,110, 32/
      DATA IPL4 / 47, 98,100, 32,123, 98,105,110,100, 32,100,101,
     &           102,125, 32, 98,105,110,100, 32,100,101,102, 32,
     &            47,101,100, 32,123,101,120, 99,104, 32,100,101,
     &           102,125, 32, 98,100, 32/
      DATA IPL5 / 47, 99,104, 32, 51, 50, 32,100,101,102, 32, 47,
     &            99,119, 32, 51, 50, 32,100,101,102, 32, 47, 99,
     &           115, 32, 48, 32,100,101,102, 32, 47, 99,114, 32,
     &            48, 32,100,101,102, 32/
      DATA IPL6 / 47,103,115, 32,123,103,115, 97,118,101,125, 32,
     &            98,100, 32, 47,103,114, 32,123,103,114,101,115,
     &           116,111,114,101,125, 32, 98,100, 32, 47, 67, 32,
     &           123,115,101,116,114,103, 98, 99,111,108,111,114,
     &           125, 32, 98,100, 32/
      DATA IPL7 / 47,109, 32,123,109,111,118,101,116,111,125, 32,
     &            98,100, 32, 47,108, 32,123,108,105,110,101,116,
     &           111,125, 32, 98,100, 32, 47, 77, 32,123,114,109,
     &           111,118,101,116,111,125, 32, 98,100, 32, 47, 76,
     &            32,123,114,108,105,110,101,116,111,125, 32, 98,
     &           100, 32/
      DATA IPL8 / 47, 84, 32,123, 47,109, 97,114,107,101,100, 32,
     &           116,114,117,101, 32,100,101,102,125, 32, 98,100,
     &            32, 47, 70, 32,123, 47,109, 97,114,107,101,100,
     &            32,102, 97,108,115,101, 32,100,101,102,125, 32,
     &           98,100, 32/
      DATA IPL9 / 47,115, 32,123, 99,117,114,114,101,110,116,112,
     &           111,105,110,116, 32,115,116,114,111,107,101, 32,
     &            84, 32,109,125, 32, 98,100, 32, 47,110, 32,123,
     &           110,101,119,112, 97,116,104,125, 32, 98,100, 32/
      DATA IPLA / 47,102, 32,123, 99,117,114,114,101,110,116,112,
     &           111,105,110,116, 32,102,105,108,108, 32, 84, 32,
     &           109,125, 32, 98,100, 32, 47,116, 32,123,115,101,
     &           116,108,105,110,101,119,105,100,116,104,125, 32,
     &            98,100,32/
      DATA IPLB / 47,105, 32,123, 48, 32, 48, 32, 48, 32, 67, 32,
     &            49, 32,115,101,116,108,105,110,101, 99, 97,112,
     &            32, 49, 32,115,101,116,108,105,110,101,106,111,
     &           105,110, 32, 48, 46, 50, 52, 32, 48, 46, 50, 52,
     &            32,115, 99, 97,108,101, 32, 55, 53, 32, 55, 53,
     &            32/
      DATA IPLC / 32,116,114, 97,110,115,108, 97,116,101, 32,102,
     &           115, 32, 70,125, 32, 98,100, 32, 47, 83, 32,123,
     &            47,115,118, 32,115, 97,118,101, 32,100,101,102,
     &            32,105,125, 32, 98,100, 32, 47, 70,111,110,116,
     &            65,114,114, 97,121, 32/
      DATA IPLD / 32, 91, 47, 84,105,109,101,115, 45, 82,111,109,
     &            97,110, 32, 47, 84,105,109,101,115, 45, 73,116,
     &            97,108,105, 99, 32, 47, 84,105,109,101,115, 45,
     &            66,111,108,100, 32, 47, 84,105,109,101,115, 45,
     &            66,111,108,100, 73,116, 97,108,105, 99, 32/
      DATA IPLE / 32, 47, 72,101,108,118,101,116,105, 99, 97, 32,
     &            47, 72,101,108,118,101,116,105, 99, 97, 45, 79,
     &            98,108,105,113,117,101, 32, 47, 72,101,108,118,
     &           101,116,105, 99, 97, 45, 66,111,108,100, 32/
      DATA IPLF / 32, 47, 72,101,108,118,101,116,105, 99, 97, 45,
     &            66,111,108,100, 79, 98,108,105,113,117,101, 32,
     &            47, 67,111,117,114,105,101,114, 32, 47, 67,111,
     &           117,114,105,101,114, 45, 79, 98,108,105,113,117,
     &           101, 32/
      DATA IPLG / 32, 47, 67,111,117,114,105,101,114, 45, 66,111,
     &           108,100, 32, 47, 67,111,117,114,105,101,114, 45,
     &            66,111,108,100, 79, 98,108,105,113,117,101, 32,
     &            47, 83,121,109, 98,111,108, 93, 32,100,101,102,
     &            32/
      DATA IPLH / 47,102,115, 32,123, 70,111,110,116, 65,114,114,
     &            97,121, 32, 99,115, 32,103,101,116, 32,102,105,
     &           110,100,102,111,110,116, 32, 49, 32,115, 99, 97,
     &           108,101,102,111,110,116, 32,115,101,116,102,111,
     &           110,116,125, 32, 98,100, 32/
      DATA IPLI / 47,115, 99,104, 32,123, 47, 99,104, 32,101,100,
     &           125, 32, 98,100, 32, 47,115, 99,119, 32,123, 47,
     &            99,119, 32,101,100,125, 32, 98,100, 32, 47,115,
     &            99,115, 32,123, 47, 99,115, 32,101,100, 32,102,
     &           115,125, 32, 98,100, 32, 47,115, 99,114, 32,123,
     &            47, 99,114, 32,101,100,125, 32, 98,100, 32/
      DATA IPLJ / 47, 99, 32,123,103,115, 32, 99,114, 32,114,111,
     &           116, 97,116,101, 32, 99,119, 32, 99,104, 32,115,
     &            99, 97,108,101, 32,115,104,111,119, 32,103,114,
     &            32, 84,125, 32, 98,100, 32/
      DATA IPLK / 47,112, 32,123,109, 97,114,107,101,100, 32,123,
     &           115,104,111,119,112, 97,103,101,125, 32,105,102,
     &            32, 99,104, 32, 99,119, 32, 99,115, 32, 99,114,
     &            32,115,118, 32,114,101,115,116,111,114,101, 32,
     &           115, 99,114, 32,115, 99,115, 32,115, 99,119, 32,
     &           115, 99,104, 32, 83,125, 32, 98,100,32/
      DATA IPLL / 47,120, 32,123,112, 32,101,110,100, 32, 83, 97,
     &           118,101,100, 83,116, 97,116,101, 32,114,101,115,
     &           116,111,114,101,125, 32, 98,100, 32, 47, 80, 32,
     &           123,115, 32,103,115, 32, 53, 32,116, 32, 48, 32,
     &            48, 32, 76, 32,115, 32,103,114,125, 32, 98,100,
     &            32/
      DATA IPLM / 47,103, 32,123, 99,117,114,114,101,110,116,102,
     &           105,108,101, 32,116,111,107,101,110, 32,112,111,
     &           112, 32, 50, 46, 51, 50, 57, 32,109,117,108, 32,
     &           100,117,112, 32, 48, 32,101,113, 32,123,112,111,
     &           112,125, 32,105,102,125, 32, 98,100, 32/
      DATA IPLN / 47, 98, 32,123, 91,103, 32,103, 32,103, 32,103,
     &            93, 32, 48, 32,115,101,116,100, 97,115,104,125,
     &            32, 98,100, 32, 83, 32/
      DATA IPLO / 37, 37, 69,110,100, 80,114,111,108,111,103, 32/
      DATA IDUMMY /0/
C
C
      IF (ICODE.LT.0.OR.ICODE.GT.13) RETURN
      IF (ICODE.NE.0) GO TO 1
C
C          THIS SECTION DOES DEVICE INITIALISATION.
C          THE SCREEN IS ERASED, THE DEFAULT HARDWARE CHARACTER
C          SIZE AND ROTATION AND FULL HARDWARE LINES ARE SET.
C
      CALL G1CMLN
      CALL G1DVIO(1,IDUMMY,1)
      CALL G1BUFF(IPL0,24)
      CALL G1FILB(0,0,-84,0)
      CALL G1BUFF(IPL1,17)
      CALL G1FILB(0,0,-84,0)
      CALL G1BUFF(IPL2,23)
      CALL G1FILB(0,0,-84,0)
      CALL G1BUFF(IPL3,35)
      CALL G1BUFF(IPL4,42)
      CALL G1BUFF(IPL5,42)
      CALL G1BUFF(IPL6,53)
      CALL G1BUFF(IPL7,62)
      CALL G1BUFF(IPL8,51)
      CALL G1BUFF(IPL9,48)
      CALL G1BUFF(IPLA,51)
      CALL G1BUFF(IPLB,61)
      CALL G1BUFF(IPLC,54)
      CALL G1BUFF(IPLD,59)
      CALL G1BUFF(IPLE,47)
      CALL G1BUFF(IPLF,50)
      CALL G1BUFF(IPLG,49)
      CALL G1BUFF(IPLH,55)
      CALL G1BUFF(IPLI,71)
      CALL G1BUFF(IPLJ,43)
      CALL G1BUFF(IPLK,70)
      CALL G1BUFF(IPLL,61)
      CALL G1BUFF(IPLM,58)
      CALL G1BUFF(IPLN,30)
      CALL G1FILB(0,0,-84,0)
      CALL G1BUFF(IPLO,12)
      CALL G1FILB(0,0,-84,0)
      CALL G1BUFF(IPAGE,17)
      CALL G1FILB(0,0,-84,0)
      CALL G1BUFF(IPBBOX,26)
      IF (ICMND(3,1).EQ.1) GO TO 8
C
      RETURN
C
C          THIS SECTION SETS THE MOST APPROPRIATE
C          HARDWARE LINE TYPE FOR THE GIVEN ARGUMENTS.
C
    1 IF (ICODE.NE.1) GO TO 4
      IF (LHRDW1) GO TO 2
C
      LHDEF1= 0
      LHDEF2= 0
      LHDEF3= 0
      LHDEF4= 0
      GO TO 3
C
    2 LHDEF1= MARKA1
      LHDEF2= MISSA1
      LHDEF3= MARKB1
      LHDEF4= MISSB1
    3 CALL G1FILB(0,0,-42,-2)
      CALL G1FILB(0,0,LHDEF1,LHDEF2)
      CALL G1FILB(0,0,LHDEF3,LHDEF4)
      RETURN
C
C          THIS SECTION SETS POSTSCRIPT CHAR. ROTATION.
C
    4 IF (ICODE.NE.2) GO TO 5
      IF (KFONT1.LT.101) RETURN
C
      IF (CURTRA) THEN
        ROT= ROTATC+ROTATS
      ELSE
        ROT= ROTATS
      ENDIF
C
      KHAR= (CRANGU+ROT)*180.0/PI+360.5
      KHAR= MOD(KHAR,360)
      CALL G1FILB(0,0,-12,KHAR)
      RETURN
C
C          THIS SECTION SETS THE CHAR. MAGN. TO THE
C          MOST APPROPRIATE VALUE FOR POSTSCRIPT CHARS.
C
    5 IF (ICODE.NE.3) GO TO 6
      IF (KFONT1.LT.101) RETURN
C
      IF (CURTRA) THEN
        SCY= SCALYC*SCALYS
      ELSE
        SCY= SCALYS
      ENDIF
C
      KHAR= (MAGN1*INT(DRESY*SCY)+500)/1000
      CALL G1FILB(0,0,-11,KHAR)
      RETURN
C
C          THIS SECTION SETS THE LINE COLOUR NUMBER.
C
    6 IF (ICODE.NE.4) GO TO 7
      IF (KOLIN1.GT.MAXCLS) KOLIN1= KOLLID
C
      CALL G1FILB(0,0,-17,KOLIN1)
      RETURN
C
C          THIS SECTION SETS PORTRAIT MODE.
C
    7 IF (ICODE.NE.5) GO TO 9
C
    8 CALL G1FILB(0,0,-21,1)
      RETURN
C
C          THIS SECTION SETS POSTSCRIPT FONT.
C
    9 IF (ICODE.NE.6) GO TO 10
      IF (KHRDW1) RETURN
      IF (KFONT1.LT.101.OR.KFONT1.GT.113) RETURN
C
      CALL G1FILB(0,0,-13,KFONT1-101)
      RETURN
C
C          THIS SECTION SETS POSTSCRIPT CHARACTER OBLATENESS.
C
   10 IF (ICODE.NE.7) GO TO 11
      IF (KHRDW1) THEN
        KHRDW1= .FALSE.
        RETURN
      ENDIF
C
      IF (KFONT1.LT.101) RETURN
C
      IF (CURTRA) THEN
        SCX= SCALXC*SCALXS
        SCY= SCALYC*SCALYS
      ELSE
        SCX= SCALXS
        SCY= SCALYS
      ENDIF
C
      IOBLAT= OBLAT1*SCX*1000.0/SCY
      CALL G1FILB(0,0,-14,IOBLAT)
      RETURN
C
C          THIS SECTION SETS A COLOUR TABLE ENTRY.
C
   11 IF (ICODE.NE.8) GO TO 12
      IF (NCOLS1.GT.MAXCLS) RETURN
C
      IREDPO(NCOLS1)= NINT(REDCO1(NCOLS1)*100.0)
      IGRNPO(NCOLS1)= NINT(GRNCO1(NCOLS1)*100.0)
      IBLUPO(NCOLS1)= NINT(BLUCO1(NCOLS1)*100.0)
      IF (NCOLS1.NE.KOLIN1) RETURN
C
      CALL G1FILB(0,0,-17,KOLIN1)
      CALL G1FILB(0,0,-84,0)
      RETURN
C
C          THIS SECTION SETS THE DEVICE RESOLUTION.
C          (IT IS NOT IMPLEMENTED IN THIS VERSION).
C
   12 IF (ICODE.NE.9) GO TO 13
      RETURN
C
C          THIS SECTION SETS THE BACKGROUND COLOUR.
C          (IT IS NOT IMPLEMENTED IN THIS VERSION).
C
   13 IF (ICODE.NE.10) GO TO 14
      RETURN
C
C          THIS SECTION BEGINS THE FILL-AREA BOUNDARY.
C
   14 IF (ICODE.NE.11) GO TO 15
      IF (KOLFL1.GT.MAXCLS) KOLFL1= KOLLID
C
      CALL G1FILB(0,0,-17,KOLFL1)
      RETURN
C
C          THIS SECTION FILLS THE GIVEN POLYGONAL AREA.
C
   15 IF (ICODE.NE.12) GO TO 16
C
      CALL G1FILB(0,0,-17,KOLIN1)
      CALL G1FILB(0,0,-84,0)
      RETURN
C
C          THIS SECTION RESETS THE SHADING OPTION FLAG.
C
   16 IFLRP1= 0
      RETURN
      END
