      SUBROUTINE G3LINK(ICLASS,IFUNCO,LENGTH,IDATA,RDATA)
C
C          ------------------------------------------------
C          ROUTINE NO. (3001)   VERSION (A8.8D)   07:NOV:96
C          ------------------------------------------------
C
C          THIS INTERFACES THE PRE-PROCESSOR ROUTINES TO THE
C          GRIDFILE-MANAGEMENT AND DEVICE-HANDLER ROUTINES.
C          (THIS VERSION IS FOR DEVICE-MODE WORKING WITH TRENC/DECODE).
C
C
C          THE ARGUMENTS ARE AS FOLLOWS:
C
C          <ICLASS> IS THE CLASS OF THE ACTION REQUIRED,
C          <IFUNCO> IS THE FUNCTION CODE WITHIN THE GIVEN CLASS,
C          <LENGTH> GIVES THE DATA LENGTH AND TYPE:
C                   < 0, THE DATA IS INTEGER, OR
C                   > 0, THE DATA TYPE IS REAL.
C          [IDATA]  ARE THE INTEGER VALUES (IF ANY), AND
C          [RDATA]  ARE THE REAL VALUES (IF ANY).
C
C
      REAL    RDATA(*),RARGS(4)
      INTEGER IDATA(*),IARGS(5)
      LOGICAL PICCOM
      LOGICAL NEWPIC,GFOPEN,PPOPEN,SHIFT0
C
      COMMON /T0CANG/ STANG0,CRANG0
      COMMON /T0CATT/ IUNDL0,ITAL0
      COMMON /T0CDIM/ MAGN0,OBLAT0
      COMMON /T0CFON/ KFONT0
      COMMON /T0CSPA/ X1CHR0,X2CHR0,Y1CHR0,Y2CHR0
      COMMON /T0CVIS/ KWIND0,KMASK0
      COMMON /T0DEVS/ KCHAN0(5),IRESL0
      COMMON /T0HANG/ HTANG0(255,2)
      COMMON /T0HCOL/ IHCOL0(255,2)
      COMMON /T0HFLG/ NHFLG0(255)
      COMMON /T0HLST/ IHMKA0(255,2),IHMSA0(255,2),IHMKB0(255,2),
     &                IHMSB0(255,2)
      COMMON /T0HOFF/ ISHFT0(255,2)
      COMMON /T0HPHS/ IPHAS0(255,2)
      COMMON /T0HPIT/ IPITH0(255,2)
      COMMON /T0HPSF/ IPSFT0(255,2)
      COMMON /T0HRDC/ KHRDW0
      COMMON /T0HRDL/ LHRDW0
      COMMON /T0HTYP/ IHAT0(255)
      COMMON /T0KBAC/ KOLBA0
      COMMON /T0KTAB/ REDCO0(255),GRNCO0(255),BLUCO0(255),NCOLS0
      COMMON /T0KTFL/ NCFLG0(255)
      COMMON /T0LATT/ KOLIN0,ITHIK0
      COMMON /T0LPAT/ MARKA0,MISSA0,MARKB0,MISSB0
      COMMON /T0MAPP/ X1MAP0,X2MAP0,Y1MAP0,Y2MAP0
      COMMON /T0MAPT/ MAPNO0
      COMMON /T0MASK/ X1MSK0(10),X2MSK0(10),Y1MSK0(10),Y2MSK0(10),MSKLV0
      COMMON /T0MRKS/ MARKC0
      COMMON /T0PPOS/ XPLOT0,YPLOT0
      COMMON /T0TRAN/ SCALX0,SCALY0,ROTAT0,RPICX0,RPICY0,RDEVX0,RDEVY0,
     &                VRPICX,VRPICY,VRDEVX,VRDEVY
      COMMON /T0TRST/ SHIFT0,MTRAN0,KLIPM0
      COMMON /T0WNDO/ X1WND0,X2WND0,Y1WND0,Y2WND0
      COMMON /T3NBYR/ NBYTR
      COMMON /T3OUTS/ GFOPEN,PPOPEN
      COMMON /T3PICM/ NEWPIC
      COMMON /T3PLVL/ LVLPIC
      COMMON /T3VBUF/ VBUFFR(63),LASCOD,INDXVB
C
C
C          THE PICTURE INSERT LEVEL IS UPDATED HERE AND A
C          'NEW OUTPUT PICTURE' COMMAND IS NOTED WHEN RECEIVED.
C
      NPTS= LENGTH/NBYTR
      ICODE= ICLASS*32+IFUNCO
      IF (ICODE.EQ.35) LVLPIC= LVLPIC+1
      IF (ICODE.EQ.33) LVLPIC= LVLPIC-1
      IF (ICODE.EQ.36) LVLPIC= 0
C
      PICCOM= .FALSE.
      IF (ICODE.EQ.99.OR.ICODE.EQ.107) PICCOM= .TRUE.
C
C          THIS SECTION BUFFERS SUCCESSIVE DRAWING FUNCTIONS.
C          IF THE BUFFER MARKER IS CLEAR, THE NEW FUNCTION IS
C          EXAMINED. OTHERWISE, IF THE CLASS IS ZERO AND THE
C          FUNCTION CODE HAS NOT CHANGED, THE DATA IS BUFFERED.
C          IF THE CLASS OR THE FUNCTION CODE HAVE CHANGED, THE
C          BUFFER IS EMPTIED AND THE NEW FUNCTION IS PROCESSED.
C          THE BUFFER MARKER IS THEN SET TO THE FUNCTION CODE.
C          (ONLY CLASS-0 FUNCTION CODES 2 TO 5 ARE BUFFERED).
C
      IF (LASCOD.EQ.0) GO TO 1
      IF (ICLASS.EQ.0.AND.IFUNCO.EQ.LASCOD) GO TO 2
C
      INDXVB= NBYTR*INDXVB
      IF (PPOPEN) CALL G1CLSN(LASCOD,INDXVB,IDATA,VBUFFR)
C
      INDXVB= 0
      LASCOD= 0
    1 IF (ICLASS.GT.0.OR.NEWPIC)      GO TO 5
      IF (IFUNCO.LT.2.OR.IFUNCO.GT.5) GO TO 5
C
      LASCOD= IFUNCO
      INDXVB= INDXVB+NPTS
      GO TO 3
C
C          THIS PART ACTUALLY BUFFERS THE INPUT DATA. IF A
C          REPEATED 'POSITION' IS ATTEMPTED, ONLY THE MOST
C          RECENT IS KEPT BY OVERWRITING THE PREVIOUS ONE.
C          THE BUFFER IS EMPTIED EACH TIME IT BECOMES FULL.
C
    2 IF (LASCOD.GE.3.AND.LASCOD.LE.5) INDXVB= INDXVB+NPTS
    3 IF (INDXVB.LE.(255/NBYTR)) GO TO 4
C
      INDXVB= NBYTR*(INDXVB-NPTS)
      IF (PPOPEN) CALL G1CLSN(LASCOD,INDXVB,IDATA,VBUFFR)
C
      INDXVB= NPTS
C
    4 DO 100 IPT= 1,NPTS
        LOAD= INDXVB+IPT-NPTS
        VBUFFR(LOAD)= RDATA(IPT)
  100 CONTINUE
      RETURN
C
C          THIS SECTION SUPPLIES THE DEVICE-HANDLER WITH DATA
C          FOR ALL FUNCTIONS OTHER THAN THOSE BUFFERED ABOVE.
C          ONLY 'GREND' IS DONE IF DEVICE OUTPUT IS DISABLED.
C          SUCCESSIVE 'NEW-PICTURE' FUNCTIONS ARE NOT SENT ON.
C
    5 IF (.NOT.PPOPEN.AND.ICODE.NE.34) GO TO 19
      IF (NEWPIC.AND.PICCOM)           GO TO 19
C
      KLASS= ICLASS+1
      GO TO (6,7,12,13,14,15,16,17), KLASS
C
    6 CALL G1CLSN(ICODE,LENGTH,IDATA,RDATA)
      GO TO 19
C
C          THIS SECTION HANDLES FUNCTIONS IN CLASS-1:
C
C          THIS DEALS WITH A 'GREND' FUNCTION.
C
    7 IF (IFUNCO.EQ.5) GO TO 19
      IF (IFUNCO.NE.2) GO TO 8
C
      CALL G1CLSN(34,0,IARGS,RARGS)
      GO TO 19
C
C          THIS DEALS WITH A 'BEGIN-INSERT' FUNCTION. IF THIS
C          IS FROM PICTURE-LEVEL 0 AND A SUBPICTURE IS TO BE
C          DONE, A 'TRANSFORM-INDENT' FUNCTION IS GENERATED.
C          ANY EXISTING CHARACTER RE-DEFINITIONS ARE STACKED.
C
C
    8 IF (IFUNCO.NE.3) GO TO 9
C
      CALL G1CLSN(35,0,IDATA,RDATA)
      IF (LVLPIC.NE.1) GO TO 19
      IF (MTRAN0.GE.2) CALL G1CLSN(238,0,IDATA,RDATA)
C
      IARGS(1)= 0
      CALL G1CLSN(79,1,IARGS,RARGS)
      GO TO 19
C
C          THIS DEALS WITH AN 'END-INSERT' FUNCTION. PRE-PROCESSOR
C          VALUES ARE RESTORED WHEN RETURNING TO PICTURE-LEVEL 0.
C          AFTER AN OVERLAY, A PRE-PROCESSOR TRANSFORM IS DONE.
C          AFTER A SUBPICTURE, A TRANSFORM UNDENT IS DONE INSTEAD.
C
    9 IF (IFUNCO.EQ.4) CALL G1CLSN(36,0,IDATA,RDATA)
      IF (IFUNCO.NE.4) CALL G1CLSN(33,0,IDATA,RDATA)
      IF (LVLPIC.NE.0) GO TO 19
C
C          THIS PART RESTORES THE MAPPING.
C
      RARGS(1)= X1MAP0
      RARGS(2)= X2MAP0
      RARGS(3)= Y1MAP0
      RARGS(4)= Y2MAP0
      MAPCOD= MAPNO0+224
      CALL G1CLSN(MAPCOD,4*NBYTR,IARGS,RARGS)
      IF (IFUNCO.NE.1) GO TO 10
C
C          THIS PART RESTORES THE WINDOW.
C
      RARGS(1)= X1WND0
      RARGS(2)= X2WND0
      RARGS(3)= Y1WND0
      RARGS(4)= Y2WND0
      CALL G1CLSN(229,4*NBYTR,IARGS,RARGS)
C
C          THIS PART RESTORES THE MASK AREAS.
C
      IARGS(1)= 0
      CALL G1CLSN(231,1,IARGS,RARGS)
C
      DO 200 LEVEL= 1,10
        RARGS(1)= X1MSK0(LEVEL)
        RARGS(2)= X2MSK0(LEVEL)
        RARGS(3)= Y1MSK0(LEVEL)
        RARGS(4)= Y2MSK0(LEVEL)
        CALL G1CLSN(230,4*NBYTR,IARGS,RARGS)
  200 CONTINUE
C
      IARGS(1)= MSKLV0
      CALL G1CLSN(231,1,IARGS,RARGS)
C
C          THE APPROPRIATE TRANSFORM STATE IS RESTORED.
C
      IARGS(1)= KLIPM0
      CALL G1CLSN(240,1,IARGS,RARGS)
      IARGS(1)= MTRAN0
      CALL G1CLSN(241,1,IARGS,RARGS)
C
C          THIS PART RESTORES THE CHARACTER ATTRIBUTES.
C          ANY STACKED CHARACTER RE-DEFINITIONS ARE RESTORED.
C
      IARGS(1)= KHRDW0
      CALL G1CLSN(65,1,IARGS,RARGS)
      IARGS(1)= KFONT0
      CALL G1CLSN(66,1,IARGS,RARGS)
      IARGS(1)= MAGN0
      CALL G1CLSN(67,1,IARGS,RARGS)
      RARGS(1)= STANG0
      CALL G1CLSN(68,NBYTR,IARGS,RARGS)
      RARGS(1)= CRANG0
      CALL G1CLSN(69,NBYTR,IARGS,RARGS)
      IARGS(1)= ITAL0
      CALL G1CLSN(70,1,IARGS,RARGS)
      IARGS(1)= IUNDL0
      CALL G1CLSN(71,1,IARGS,RARGS)
      RARGS(1)= OBLAT0
      CALL G1CLSN(72,NBYTR,IARGS,RARGS)
      IARGS(1)= MARKC0
      CALL G1CLSN(73,1,IARGS,RARGS)
C
C          THIS PART RESTORES THE CHARACTER WINDOW.
C
      RARGS(1)= X1CHR0
      RARGS(2)= X2CHR0
      RARGS(3)= Y1CHR0
      RARGS(4)= Y2CHR0
      CALL G1CLSN(74,4*NBYTR,IARGS,RARGS)
      IARGS(1)= KWIND0
      CALL G1CLSN(77,1,IARGS,RARGS)
      IARGS(1)= KMASK0
      CALL G1CLSN(78,1,IARGS,RARGS)
C
C          THIS PART RESTORES THE LINE ATTRIBUTES.
C
      IARGS(1)= ITHIK0
      CALL G1CLSN(100,1,IARGS,RARGS)
      IARGS(1)= MARKA0
      IARGS(2)= MISSA0
      IARGS(3)= MARKB0
      IARGS(4)= MISSB0
      CALL G1CLSN(102,4,IARGS,RARGS)
      IARGS(1)= LHRDW0
      CALL G1CLSN(103,1,IARGS,RARGS)
      IARGS(1)= KOLIN0
      CALL G1CLSN(105,1,IARGS,RARGS)
C
C          THIS PART RESTORES THE DEVICE RESOLUTION:
C
      IARGS(1)= IRESL0
      CALL G1CLSN(108,1,IARGS,RARGS)
C
C          THIS PART RESTORES THE COLOUR DEFINITIONS:
C
      DO 300 NCOLTB= 1,NCOLS0
        IF (NCFLG0(NCOLTB).NE.0) THEN
          RARGS(1)= NCOLTB
          RARGS(2)= REDCO0(NCOLTB)
          RARGS(3)= GRNCO0(NCOLTB)
          RARGS(4)= BLUCO0(NCOLTB)
          CALL G1CLSN(161,4*NBYTR,IARGS,RARGS)
        ENDIF
C        
  300 CONTINUE
C
C          THIS PART RESTORES THE SHADING PATTERN DEFINITIONS.
C
      DO 400 NHATAB= 65,255
        IF (NHFLG0(NHATAB).NE.0) THEN
          IARGS(1)= NHATAB
          CALL G1CLSN(172,-1,IARGS,RARGS)
          RARGS(1)= HTANG0(NHATAB,1)
          RARGS(2)= 1.0
          CALL G1CLSN(165,2*NBYTR,IARGS,RARGS)
          RARGS(1)= HTANG0(NHATAB,2)
          RARGS(2)= 2.0
          CALL G1CLSN(165,2*NBYTR,IARGS,RARGS)
          IARGS(1)= IPITH0(NHATAB,1)
          IARGS(2)= 1
          CALL G1CLSN(166,-2,IARGS,RARGS)
          IARGS(1)= IPITH0(NHATAB,2)
          IARGS(2)= 2
          CALL G1CLSN(166,-2,IARGS,RARGS)
          IARGS(1)= ISHFT0(NHATAB,1)
          IARGS(2)= 1
          CALL G1CLSN(167,-2,IARGS,RARGS)
          IARGS(1)= ISHFT0(NHATAB,2)
          IARGS(2)= 2
          CALL G1CLSN(167,-2,IARGS,RARGS)
          IARGS(1)= IHMKA0(NHATAB,1)
          IARGS(2)= IHMSA0(NHATAB,1)
          IARGS(3)= IHMKB0(NHATAB,1)
          IARGS(4)= IHMSB0(NHATAB,1)
          IARGS(5)= 1
          CALL G1CLSN(168,-5,IARGS,RARGS)
          IARGS(1)= IHMKA0(NHATAB,2)
          IARGS(2)= IHMSA0(NHATAB,2)
          IARGS(3)= IHMKB0(NHATAB,2)
          IARGS(4)= IHMSB0(NHATAB,2)
          IARGS(5)= 2
          CALL G1CLSN(168,-5,IARGS,RARGS)
          IARGS(1)= IPHAS0(NHATAB,1)
          IARGS(2)= 1
          CALL G1CLSN(169,-2,IARGS,RARGS)
          IARGS(1)= IPHAS0(NHATAB,2)
          IARGS(2)= 2
          CALL G1CLSN(169,-2,IARGS,RARGS)
          IARGS(1)= IHCOL0(NHATAB,1)
          IARGS(2)= 1
          CALL G1CLSN(170,-2,IARGS,RARGS)
          IARGS(1)= IHCOL0(NHATAB,2)
          IARGS(2)= 2
          CALL G1CLSN(170,-2,IARGS,RARGS)
          IARGS(1)= IHAT0(NHATAB)
          CALL G1CLSN(171,-1,IARGS,RARGS)
          IARGS(1)= IPSFT0(NHATAB,1)
          IARGS(2)= 1
          CALL G1CLSN(175,-2,IARGS,RARGS)
          IARGS(1)= IPSFT0(NHATAB,2)
          IARGS(2)= 2
          CALL G1CLSN(175,-2,IARGS,RARGS)
        ENDIF
C        
  400 CONTINUE
C
      IARGS(1)= KOLBA0
      CALL G1CLSN(162,1,IARGS,RARGS)
   10 IARGS(1)= 1
      CALL G1CLSN(79,1,IARGS,RARGS)
      IF (MTRAN0.GE.2) GO TO 11
C
C          THIS PART IS FOR END-OF-OVERLAY.
C
      RARGS(1)= VRPICX
      RARGS(2)= VRPICY
      CALL G1CLSN(2,2*NBYTR,IARGS,RARGS)
      RARGS(1)= SCALX0
      CALL G1CLSN(232,NBYTR,IARGS,RARGS)
      RARGS(1)= SCALY0
      CALL G1CLSN(233,NBYTR,IARGS,RARGS)
      RARGS(1)= ROTAT0
      CALL G1CLSN(236,NBYTR,IARGS,RARGS)
      RARGS(1)= RDEVX0
      RARGS(2)= RDEVY0
      LENDA= 0
      IF (SHIFT0) LENDA= 2*NBYTR
C
      CALL G1CLSN(237,LENDA,IARGS,RARGS)
      RARGS(1)= XPLOT0
      RARGS(2)= YPLOT0
      CALL G1CLSN(2,2*NBYTR,IARGS,RARGS)
      GO TO 19
C
C          THIS PART IS FOR END-OF-SUBPICTURE.
C
   11 RDATA(1)= 1.0
      RDATA(2)= 1.0
      RDATA(3)= 0.0
      RDATA(4)= 0.0
      RDATA(5)= 0.0
      RDATA(6)= 0.0
      RDATA(7)= 0.0
      CALL G1CLSN(239,7*NBYTR,IDATA,RDATA)
      RARGS(1)= XPLOT0
      RARGS(2)= YPLOT0
      CALL G1CLSN(2,2*NBYTR,IARGS,RARGS)
      GO TO 19
C
C          THIS SECTION HANDLES FUNCTIONS IN CLASSES 2
C          TO 7 (BUT CLASS 6 IS NOT SUPPORTED HERE).
C
C
   12 CALL G1CLSN(ICODE,LENGTH,IDATA,RDATA)
      GO TO 19
C
   13 CALL G1CLSN(ICODE,LENGTH,IDATA,RDATA)
      GO TO 19
C
   14 CALL G1CLSN(ICODE,LENGTH,IDATA,RDATA)
      GO TO 19
C
   15 CALL G1CLSN(ICODE,LENGTH,IDATA,RDATA)
      GO TO 19
C
   16 GO TO 19
C
C          WHEN A TRANSFORM UNDENT IS BEING DONE TO PICTURE-LEVEL 1,
C          THE FUNCTION VALUES ARE REPLACED BY THE PRE-PROCESSOR ONES.
C
   17 IF (LVLPIC.NE.1.OR.IFUNCO.NE.15) GO TO 18
C
      RDATA(1)= SCALX0
      RDATA(2)= SCALY0
      RDATA(3)= ROTAT0
      RDATA(4)= RDEVX0
      RDATA(5)= RDEVY0
      RDATA(6)= RPICX0
      RDATA(7)= RPICY0
C
   18 CALL G1CLSN(ICODE,LENGTH,IDATA,RDATA)
   19 NEWPIC= PICCOM
      RETURN
      END
