      SUBROUTINE INTERP(NAME,MODE)
C
C          ------------------------------------------------
C          ROUTINE NO. (5002)   VERSION (A8.4C)   05:MAR:92
C          ------------------------------------------------
C
C          THIS IS THE INTERACTIVE GRAPHICAL INTERPRETER.
C
C
C          IF NON-EMPTY, [NAME] SPECIFIES (PACKED, WITH END CHARACTER)
C          A GRIDFILE TO BE DISPLAYED IMMEDIATELY. IF <MODE>= 1, THE
C          INTERPRETER THEN ENTERS INTERACTIVE MODE AND AWAITS COMMANDS.
C          OTHERWISE, THE ROUTINE EXITS AFTER THE FILE HAS BEEN DONE.
C
C
      INTEGER NAME(32),NAMFIL(32),MAPCHR(7,24),ICOMND(128),ISTRI1(20),
     &        IYES(3),LOAD1(133),LOAD2(35),KONT(2)
      LOGICAL BEGUN
      LOGICAL ERRON
      CHARACTER LINE(128),SPAC
      CHARACTER FILE*128,STRNG1*128,STRNG2*16
C+PJK 30/03/05
      EXTERNAL SCALE
C-PJK
C
      COMMON /T3CHAM/ KMESGI,KMESGO
      COMMON /T3ERRS/ ERRON,NUMERR
      COMMON /T3FILL/ LENDEF,LENSCR
      COMMON /T3FILN/ NAMDEF(32),NAMSCR(32)
      COMMON /T3MACH/ NMCHI,NBITMC
      COMMON /T3SPAC/ ISPACE(1)
C
      EQUIVALENCE (LOAD1(1),MAPCHR(1,1)),(LOAD2(1),MAPCHR(1,20))
C
      SAVE LOAD1,LOAD2,MAPCHR
C
C
C          THE AVAILABLE COMMANDS (WITH ABBREVIATIONS) ARE:
C
C                           DEVOF F
C                           DEVON
C                              EN D
C                              ER ASE
C                            FILE ND
C                            FILI NF
C                            FILN AM
C                           FILOF F
C                           FILON
C                              FR AME
C                              GR END
C                              LI ST
C                              LO CATE
C                            PICI NF
C                            PICN AM
C                            PICS AV
C                            PICT UR
C                              PO SITN
C                              QU IT
C                              RO TATE
C                            SCAL E
C                            SCAR OT
C                              ST OP
C                              UN LOC
C
      DATA LOAD1  /68,69,86,79,70,70,  5,
     &             68,69,86,79,78, 0,  5,
     &             69,78,68,0,0,0,     2,
     &             69,82,65,83,69, 0,  2,
     &             70,73,76,69,78,68,  4,
     &             70,73,76,73,78,70,  4,
     &             70,73,76,78,65,77,  4,
     &             70,73,76,79,70,70,  5,
     &             70,73,76,79,78, 0,  5,
     &             70,82,65,77,69, 0,  2,
     &             71,82,69,78,68, 0,  2,
     &             76,73,83,84, 0, 0,  2,
     &             76,79,67,65,84,69,  2,
     &             80,73,67,73,78,70,  4,
     &             80,73,67,78,65,77,  4,
     &             80,73,67,83,65,86,  4,
     &             80,73,67,84,85,82,  4,
     &             80,79,83,73,84,78,  2,
     &             81,85,73,84, 0, 0,  2/
      DATA LOAD2  /82,79,84,65,84,69,  2,
     &             83,67,65,76,69, 0,  4,
     &             83,67,65,82,79,84,  4,
     &             83,84,79,80, 0, 0,  2,
     &             85,78,76,79,67, 0,  2/
C
C          (THE END CHARACTER IS AN EXCLAMATION MARK).
C
      DATA IYES /89,69,83/, NSPACE /32/, IENDCH /33/,
     &     NOPTS /24/
C
C
      CALL PAPER(1)
      CALL FILOFF
      SPAC= CHAR(ISPACE(1))
      IF (MODE.NE.0) WRITE(KMESGO,201)
  201 FORMAT(1X,'++ GHOST-80 COMMAND INTERPRETER ++')
C
      BEGUN= .FALSE.
      LENGTH= 0
C
      DO 100 LOOK= 1,128
        CALL G4GETK(NAME,LOOK,NBITMC,NMCHI,MCHAR)
        CALL G4COCO(MCHAR,KCHAR)
        IF (KCHAR.LT.NSPACE)                GO TO 100
        IF (KCHAR.EQ.NSPACE.AND..NOT.BEGUN) GO TO 100
C
        BEGUN= .TRUE.
C  test for trailing space removed
CC        IF (KCHAR.EQ.NSPACE) GO TO 1
        IF (KCHAR.EQ.IENDCH) GO TO 1
C
        LENGTH= LENGTH+1
        CALL G4PUTK(NAMFIL,LENGTH,NBITMC,NMCHI,MCHAR)
  100 CONTINUE
C
    1 IF (LENGTH.LE.0) GO TO 2
C
      CALL G3FLIN(NAMFIL,NAMFIL,LENGTH,0,0)
      CALL G2FILE(NAMFIL,NAMFIL,NAMFIL,NAMFIL,0,0,0,0,5,ISTATE)
      IF (ISTATE.GT.2)  GO TO 1011
C
      CALL ENQRUN(KONT)
      IF (KONT(1).NE.0) GO TO 1011
      IF (KONT(2).NE.0) GO TO 1011
C
    2 IF (MODE.NE.1)    GO TO 1011
C
C          THE REMAINDER OF THE ROUTINE IS THE INTERACTIVE SECTION.
C          THIS READS IN COMMAND LINES, CONVERTS THEM TO UNPACKED
C          RIGHT-JUSTIFIED GHOST-CHARACTER FORM, THEN ATTEMPTS TO
C          INTERPRET THE FIRST WORD AS A COMMAND AND THE REMAINDER
C          (IF THERE IS SUCH) AS THE APPROPRIATE SET OF ARGUMENTS.
C
      WRITE(KMESGO,202)
  202 FORMAT(1X,'(The command LIST shows all available commands)')
      CALL FILON
      CALL PSPACE(0.0,1.0,0.0,1.0)
      CALL TPICT(2)
      CALL GPSTOP(9999)
C
      DO 200 ICOPY= 1,128
        CALL G4GETK(NAMDEF,ICOPY,NBITMC,NMCHI,MCHAR)
        FILE(ICOPY:ICOPY)= CHAR(MCHAR)
  200 CONTINUE
C
    3 DO 300 ICOPY= 1,128
        LINE(ICOPY)= SPAC
  300 CONTINUE
C
      CALL PICNOW
      WRITE(KMESGO,203)
  203 FORMAT(1X,'CMND?')
      READ(KMESGI,101) (LINE(IN), IN= 1,128)
  101 FORMAT(128A1)
      CALL G5JUSR(LINE,ICOMND,128,LENLIN,2)
      IF (LENLIN.LE.0) GO TO 3
C
C          THE POSITION OF THE FIRST ALPHABETIC CHARACTER IS
C          FOUND, THEN THE PLACE OF THE NEXT NON-ALPHA CHAR.
C
      CALL G4NEXC(ICOMND,1,LENLIN,128,+3,ISTART)
      IEND= ISTART
      IF (ISTART.LE.0) GO TO 5
C
      CALL G4NEXC(ICOMND,ISTART,LENLIN,128,-3,IEND)
      IF (IEND.LE.0) IEND= LENLIN
C
      NCHARS= IEND-ISTART
C
C          AS A FIRST ATTEMPT, THE COMMAND IS COMPARED WITH EACH
C          AVAILABLE OPTION CHARACTER-BY-CHARACTER TO SEE IF A
C          COMPLETE MATCH IS ACHIEVED FOR THE SUPPLIED CHARACTERS,
C          SUBJECT TO THE MINIMUM CHARACTER COUNT FOR THAT OPTION.
C
      DO 400 NUMOPT= 1,NOPTS
        IF (NCHARS.LT.MAPCHR(7,NUMOPT)) GO TO 400
C
        DO 500 LOOK= 1,NCHARS
          ICHR= LOOK+ISTART-1
          IF (ICOMND(ICHR).GE.97.AND.ICOMND(ICHR).LE.122)
     &        ICOMND(ICHR)= ICOMND(ICHR)-32
          IF (ICOMND(ICHR).NE.MAPCHR(LOOK,NUMOPT)) GO TO 400
  500   CONTINUE
C
        GO TO 8
  400 CONTINUE
C
C          THIS SECTION IS ENTERED IF DIRECT COMPARISON IS
C          NOT SUCCESSFUL; THIS DOES A 'CORRELATION SEARCH'.
C          IF THE LEVEL OF CONFIDENCE IS GOOD ENOUGH, THE
C          OPTION NUMBER IS SET AND THE ROUTINE PROCEEDS.
C
      IF (NCHARS.LE.1) GO TO 5
C
      LOLIM= 2-NCHARS
      NCMAX= 0
      NCNEX= 0
      MAXOPT= 0
C
      DO 600 NUMOPT= 1,NOPTS
        NCNOW= 0
C
        DO 700 IOFFST= LOLIM,4
          ICNOW= 0
C
          DO 800 LOOK= 1,NCHARS
            ICHARO= LOOK+IOFFST
            IF (ICHARO.LE.0)                GO TO 800
            IF (ICHARO.GT.6)                GO TO 800
            IF (MAPCHR(ICHARO,NUMOPT).EQ.0) GO TO 800
C
            ICHARC= LOOK+ISTART-1
            IF (ICOMND(ICHARC).EQ.MAPCHR(ICHARO,NUMOPT)) GO TO 4
            IF (ICNOW.EQ.1) NCNOW= NCNOW-1
C
            ICNOW= 0
            GO TO 800
C
    4       ICNOW= ICNOW+1
            NCNOW= NCNOW+1
  800     CONTINUE
C
          IF (ICNOW.EQ.1) NCNOW= NCNOW-1
  700   CONTINUE
C
        IF (NCNOW.LE.NCNEX) GO TO 600
C
        NCNEX= NCNOW
        IF (NCNOW.LT.NCMAX) GO TO 600
C
        NCNEX= NCMAX
        NCMAX= NCNOW
        MAXOPT= NUMOPT
  600 CONTINUE
C
      IF (NCMAX-2.GT.NCNEX) GO TO 7
      IF (NCMAX.GT.0)       GO TO 6
C
C          THIS SECTION IS ENTERED IF THE COMMAND IS NOT RECOGNISED.
C
    5 NSPACS= 16+ISTART-IEND
      IEND= IEND-1
      WRITE(KMESGO,204) (SPAC, IOUT= 1,NSPACS),
     &                  (LINE(IOUT), IOUT= ISTART,IEND)
  204 FORMAT(1X,16A1,' doesn''t exist; please try again...')
      GO TO 3
C
C          THIS SECTION ASKS FOR VERIFICATION OF THE COMMAND
C          AND CONTINUES NORMALLY IF THE REPLY 'YES' IS GIVEN.
C
    6 DO 900 ICOPY= 1,6
        ISTRI1(ICOPY)= MAPCHR(ICOPY,MAXOPT)
  900 CONTINUE
C
      CALL G5JUSL(ISTRI1,LINE,6,LENGTH,3)
      WRITE(KMESGO,205) (LINE(IOUT), IOUT= 1,LENGTH)
  205 FORMAT(1X,'Don''t you mean ',6A1,' ?')
      READ(KMESGI,102) (LINE(IN), IN= 1,20)
  102 FORMAT(20A1)
      CALL G5JUSR(LINE,ISTRI1,20,LENGTH,3)
      LENGTH= LENGTH-1
      IF (LENGTH.LE.0) GO TO 5
C
      DO 1000 LOOK= 1,LENGTH
        IF (ISTRI1(LOOK).NE.IYES(LOOK)) GO TO 5
 1000 CONTINUE
C
    7 NUMOPT= MAXOPT
C
C          THIS PART DIRECTS CONTROL TO THE APPROPRIATE SECTION
C          FOR THE DECODING OF THE REMAINDER OF THE COMMAND LINE.
C
    8 ISTART= IEND
C
      GO TO (1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,
     &       1011,1012,1013,1014,1015,1016,1017,1018,1019,1020,
     &       1021,1022,1023,1024), NUMOPT
C
C          THE SECTIONS BELOW EXECUTE THE FOLLOWING COMMANDS:
C
C                    ** DEVOFF **
C
 1001 CALL DEVOFF
      GO TO 3
C
C                    ** DEVON **
C
 1002 CALL DEVON
      GO TO 3
C
C                    ** END **
C
C          (THIS IS THE SAME AS GREND).
C
 1003 GO TO 1011
C
C                    ** ERASE **
C
 1004 CALL ERASE
      GO TO 3
C
C                    ** FILEND **
C
 1005 CALL FILEND
      GO TO 3
C
C                    ** FILINF (INFO) **
C
 1006 CALL G4NEXS(ICOMND,ISTART,LENLIN,128,STRNG1,128,LENST1,IEND)
      IF (LENST1.LE.0) GO TO 901
C
      CALL FILINF(STRNG1)
      GO TO 3
C
C                    ** FILNAM (NAME) **
C
 1007 CALL G4NEXS(ICOMND,ISTART,LENLIN,128,STRNG1,128,LENST1,IEND)
      IF (LENST1.LE.0) GO TO 901
C
      CALL FILNAM(STRNG1)
      GO TO 3
C
C                    ** FILOFF **
C
 1008 CALL FILOFF
      GO TO 3
C
C                    ** FILON **
C
 1009 CALL FILON
      GO TO 3
C
C                    ** FRAME **
C
 1010 CALL FRAME
      GO TO 3
C
C                    ** GREND **
C
 1011 CALL GREND
C
      IF (MODE.NE.0) WRITE(KMESGO,206)
  206 FORMAT(1X,'++ GHOST-80 COMMAND INTERPRETER ENDS ++')
      RETURN
C
C                    ** LIST **
C
 1012 LINPOS= 0
C
      DO 1100 NUMOPT= 1,NOPTS
        ICOMND(LINPOS+1)= 32
        ICOMND(LINPOS+2)= 32
        ICOMND(LINPOS+3)= 32
        ICOMND(LINPOS+4)= 32
        LINPOS= LINPOS+4
C
        DO 1200 ICOPY= 1,6
          KCHAR= MAPCHR(ICOPY,NUMOPT)
          IF (KCHAR.EQ.0) KCHAR= 32
C
          ICOMND(ICOPY+LINPOS)= KCHAR
 1200   CONTINUE
C
        LINPOS= LINPOS+6
        IF (LINPOS.LT.60.AND.NUMOPT.LT.NOPTS) GO TO 1100
C
        CALL G5JUSL(ICOMND,LINE,60,LENGTH,0)
        WRITE(KMESGO,207) (LINE(IOUT), IOUT= 1,LINPOS)
  207   FORMAT(1X,60A1)
        LINPOS= 0
 1100 CONTINUE
      GO TO 3
C
C                    ** LOCATE (XPIC,YPIC) **
C
 1013 CALL G4NEXR(ICOMND,ISTART,LENLIN,128,XPOSL,NDIGS,IEND)
      IF (NDIGS.LE.0) GO TO 901
      IF (IEND.LE.0)  GO TO 901
C
      ISTART= IEND
      CALL G4NEXR(ICOMND,ISTART,LENLIN,128,YPOSL,NDIGS,IEND)
      IF (NDIGS.LE.0) GO TO 901
      IF (IEND.LE.0)  GO TO 901
C
      CALL LOCATE(XPOSL,YPOSL)
      GO TO 3
C
C                    ** PICINF (INFO) **
C
 1014 CALL G4NEXS(ICOMND,ISTART,LENLIN,128,STRNG1,128,LENST1,IEND)
      IF (LENST1.LE.0) GO TO 901
C
      CALL PICINF(STRNG1)
      GO TO 3
C
C                    ** PICNAM (NAME) **
C
 1015 CALL G4NEXS(ICOMND,ISTART,LENLIN,128,STRNG2,16,LENST1,IEND)
      IF (LENST1.LE.0) GO TO 901
C
      CALL PICNAM(STRNG2)
      GO TO 3
C
C                    ** PICSAV (NAMFIL,NAMPIC) **
C
 1016 CALL G4NEXS(ICOMND,ISTART,LENLIN,128,STRNG1,128,LENST1,IEND)
      IF (LENST1.LE.0) GO TO 901
      IF (IEND.LE.0)   GO TO 901
C
      ISTART= IEND
      CALL G4NEXC(ICOMND,ISTART,LENLIN,128,+3,IPOSL)
      IF (IPOSL.LE.0) GO TO 9
C
      CALL G4NEXS(ICOMND,ISTART,LENLIN,128,STRNG2,16,LENST1,IEND)
    9 CALL PICSAV(STRNG1,STRNG2)
      GO TO 3
C
C          ** PICTUR (FILNAM,<PICNAM> OR <NUMPIC1><,NUMPIC2>) **
C
 1017 CALL G4NEXC(ICOMND,ISTART,LENLIN,128,+2,IPOSN)
      CALL G4NEXC(ICOMND,ISTART,LENLIN,128,+3,IPOSL)
      IF (IPOSN.LE.0.AND.IPOSL.LE.0) GO TO 12
      IF (IPOSN.LE.0) IPOSN= LENLIN
      IF (IPOSL.LE.0) IPOSL= LENLIN
      IF (IPOSN.LT.IPOSL) GO TO 10
C
      CALL G4NEXS(ICOMND,ISTART,LENLIN,128,FILE,128,LENNAM,IEND)
C
      DO 1300 ICOPY= 1,128
        MCHAR= ICHAR(FILE(ICOPY:ICOPY))
        CALL G4PUTK(NAMFIL,ICOPY,NBITMC,NMCHI,MCHAR)
 1300 CONTINUE
C
      ISTART= IEND
      CALL G4NEXC(ICOMND,ISTART,LENLIN,128,+2,IPOSN)
      CALL G4NEXC(ICOMND,ISTART,LENLIN,128,+3,IPOSL)
      IF (IPOSN.LE.0.AND.IPOSL.LE.0) GO TO 12
      IF (IPOSN.LE.0) IPOSN= LENLIN
      IF (IPOSL.LE.0) IPOSL= LENLIN
      IF (IPOSN.LT.IPOSL) GO TO 10
C
      CALL G4NEXS(ICOMND,ISTART,LENLIN,128,STRNG2,16,LENST1,IEND)
      CALL PICTUR(FILE,STRNG2,0)
      GO TO 3
C
   10 CALL G4NEXI(ICOMND,ISTART,LENLIN,128,NBEG,LENGTH,IEND)
      IF (NBEG.LT.0) NBEG= -NBEG-1
      IF (LENGTH.LE.0) NBEG= 1
C
      CALL G4NEXC(ICOMND,IEND,LENLIN,128,+2,IPOSN)
      IF (IPOSN.GT.0) GO TO 11
C
      CALL PICTUR(FILE,STRNG2,NBEG)
      GO TO 3
C
   11 CALL G4NEXI(ICOMND,IEND,LENLIN,128,NEND,LENGTH,IPOSN)
      IF (NEND.LT.0) NEND= -NEND-1
      IF (LENGTH.LE.0) NEND= NBEG
C
      ERRON= .FALSE.
      NUMERR= 0
C
      DO 1400 NPIC= NBEG,NEND
        CALL G3FLIN(NAMFIL,NAMFIL,LENNAM,0,-NPIC)
        IF (NUMERR.NE.0) GO TO 3
 1400 CONTINUE
C
      ERRON= .TRUE.
      GO TO 3
C
   12 CALL G3FLIN(NAMFIL,NAMFIL,LENNAM,0,0)
      GO TO 3
C
C                    ** POSITN (XPOS,YPOS) **
C
 1018 CALL G4NEXR(ICOMND,ISTART,LENLIN,128,XPOSN,NDIGS,IEND)
      IF (NDIGS.LE.0) GO TO 901
      IF (IEND.LE.0)  GO TO 901
C
      ISTART= IEND
      CALL G4NEXR(ICOMND,ISTART,LENLIN,128,YPOSN,NDIGS,IEND)
      IF (NDIGS.LE.0) GO TO 901
      IF (IEND.LE.0)  GO TO 901
C
      CALL POSITN(XPOSN,YPOSN)
      GO TO 3
C
C                    ** QUIT **
C
C          (THIS IS THE SAME AS GREND).
C
 1019 GO TO 1011
C
C                    ** ROTATE (ANGLE) **
C
 1020 CALL G4NEXR(ICOMND,ISTART,LENLIN,128,ANGLE,NDIGS,IEND)
      IF (NDIGS.LE.0) GO TO 901
      IF (IEND.LE.0)  GO TO 901
C
      CALL ROTATE(ANGLE)
      GO TO 3
C
C                    ** SCALE (XSCALE,YSCALE) **
C
 1021 CALL G4NEXR(ICOMND,ISTART,LENLIN,128,XSCALE,NDIGS,IEND)
      IF (NDIGS.LE.0) GO TO 901
      IF (IEND.LE.0)  GO TO 901
C
      ISTART= IEND
      CALL G4NEXR(ICOMND,ISTART,LENLIN,128,YSCALE,NDIGS,IEND)
      IF (NDIGS.LE.0) GO TO 901
      IF (IEND.LE.0)  GO TO 901
C
      CALL SCALE(XSCALE,YSCALE)
      GO TO 3
C
C                    ** SCAROT (XSCALE,YSCALE,ANGLE) **
C
 1022 CALL G4NEXR(ICOMND,ISTART,LENLIN,128,XSCALE,NDIGS,IEND)
      IF (NDIGS.LE.0) GO TO 901
      IF (IEND.LE.0)  GO TO 901
C
      ISTART= IEND
      CALL G4NEXR(ICOMND,ISTART,LENLIN,128,YSCALE,NDIGS,IEND)
      IF (NDIGS.LE.0) GO TO 901
      IF (IEND.LE.0)  GO TO 901
C
      ISTART= IEND
      CALL G4NEXR(ICOMND,ISTART,LENLIN,128,ANGLE,NDIGS,IEND)
      IF (NDIGS.LE.0) GO TO 901
      IF (IEND.LE.0)  GO TO 901
C
      CALL SCAROT(XSCALE,YSCALE,ANGLE)
      GO TO 3
C
C                    ** STOP **
C
C          (THIS IS THE SAME AS GREND).
C
 1023 GO TO 1011
C
C                    ** UNLOC **
C
 1024 CALL UNLOC
      GO TO 3
C
C          THIS PART SENDS AN ERROR MESSAGE FOR WRONG ARGUMENTS.
C
  901 CALL PICNOW
      WRITE(KMESGO,208)
  208 FORMAT(1X,'The argument is incorrect; please try again')
      GO TO 3
C
      END