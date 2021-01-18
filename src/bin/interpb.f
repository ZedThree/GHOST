      SUBROUTINE INTERP(NAME,MODE)
C
C          ------------------------------------------------
C          ROUTINE NO. (5002)   VERSION (A8.1B)   20:DEC:91
C          ------------------------------------------------
C
C          THIS IS THE INTERACTIVE SERIAL GRIDFILE PROCESSOR
C          WHICH PROVIDES A DECODED OR TRANSLATED VERSION OF
C          THE GRIDFILE.
C
C
C          IF NON-EMPTY, [NAME] SPECIFIES (PACKED, WITH END CHARACTER)
C          A GRIDFILE TO BE DISPLAYED IMMEDIATELY. IF <MODE>= 1, THE
C          PROCESSOR THEN ENTERS INTERACTIVE MODE AND AWAITS COMMANDS.
C          OTHERWISE, THE ROUTINE EXITS AFTER THE FILE HAS BEEN DONE.
C
C
      INTEGER   NAME(32),NAMFIL(32),KONT(2),IDATA(1)
      LOGICAL   BEGUN
      LOGICAL   GFOPEN,PPOPEN
      CHARACTER CMNAM*128,HALT(3)*4
C
      COMMON /T3OUTS/ GFOPEN,PPOPEN
      COMMON /T3CHAM/ KMESGI,KMESGO
      COMMON /T3MACH/ NMCHI,NBITMC
C
C          (THE END CHARACTER IS AN EXCLAMATION MARK).
C
      DATA IDATA /1/, NSPACE /32/, IENDCH /33/
      DATA HALT  /'STOP','stop','    '/
C
C
C          THE SYSTEM IS INITIALISED AND GRIDFILE OUTPUT IS STOPPED.
C
      CALL G3INIT(2)
      GFOPEN= .FALSE.
C
      IF (MODE.NE.0) WRITE(KMESGO,201)
  201 FORMAT(1X,'++ GHOST-80 SERIAL GRIDFILE PROCESSOR ++')
C
C          THE INPUT NAME IS THEN COPIED TO THE ACTUAL NAME, (BAD
C          CHARACTERS AND LEADING SPACES REMOVED) UNTIL THE END
C          CHAR. OR TRAILING SPACE IS ENCOUNTERED.
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
C test for traialing space removed
CC        IF (KCHAR.EQ.NSPACE) GO TO 1
        IF (KCHAR.EQ.IENDCH) GO TO 1
C
        LENGTH= LENGTH+1
        CALL G4PUTK(NAMFIL,LENGTH,NBITMC,NMCHI,MCHAR)
  100 CONTINUE
C
C          IF THE ACTUAL NAME IS NON-NULL, <G3FLIN> IS THEN CALLED
C          TO RETRIEVE THE WHOLE FILE. <G2FILE> THEN CLOSES THE FILE.
C          IF A FATAL DEVICE OR GRIDFILE ERROR OCCURS DURING THESE
C          OPERATIONS, THE INTERPRETER IS NOT ALLOWED TO CONTINUE.
C
    1 IF (LENGTH.LE.0) GO TO 2
C
      CALL G3FLIN(NAMFIL,NAMFIL,LENGTH,0,0)
      CALL G2FILE(IDATA,IDATA,IDATA,IDATA,0,0,0,0,5,ISTATE)
      IF (ISTATE.GT.2)  GO TO 5
C
      CALL ENQRUN(KONT)
      IF (KONT(1).NE.0) GO TO 5
      IF (KONT(2).NE.0) GO TO 5
C
C          IF INTERACTIVE MODE IS NOT REQUIRED, NO MORE IS DONE.
C          THE REMAINDER OF THE ROUTINE IS THE INTERACTIVE SECTION.
C
    2 IF (MODE.NE.1)    GO TO 5
C
    3   WRITE(KMESGO,202)
  202   FORMAT(1X,'Enter file name (or STOP to end):')
        CMNAM= '    '
        READ(KMESGI,101) CMNAM
  101   FORMAT(A)
        IF (CMNAM.EQ.HALT(1)) GO TO 5
        IF (CMNAM.EQ.HALT(2)) GO TO 5
        IF (CMNAM.EQ.HALT(3)) GO TO 5
C
        BEGUN= .FALSE.
        LENGTH= 0
C
        DO 200 LOOK= 1,128
          MCHAR= ICHAR(CMNAM(LOOK:LOOK))
          CALL G4COCO(MCHAR,KCHAR)
          IF (KCHAR.LT.NSPACE)                GO TO 200
          IF (KCHAR.EQ.NSPACE.AND..NOT.BEGUN) GO TO 200
C
          BEGUN= .TRUE.
          IF (KCHAR.EQ.NSPACE) GO TO 4
          IF (KCHAR.EQ.IENDCH) GO TO 4
C
          LENGTH= LENGTH+1
          CALL G4PUTK(NAMFIL,LENGTH,NBITMC,NMCHI,MCHAR)
  200   CONTINUE
C
C          EACH TIME A FILE IS GIVEN, THE SYSTEM IS INITIALISED.
C          <G3FLIN> RETRIEVES THE GRIDFILE, AND <G2FILE> CLOSES
C          IT AFTERWARDS. THIS IS NECESSARY TO ENSURE THAT THE
C          GRIDFILE HANDLER AND GHOST REMAIN IN SYNCHRONISATION
C          WHEN ANY MORE CALLS TO <G3INIT> AND <G1INIT> ARE MADE.
C
    4   IF (LENGTH.LE.0) GO TO 3
C
        CALL G3INIT(1)
        GFOPEN= .FALSE.
        CALL G3FLIN(NAMFIL,NAMFIL,LENGTH,0,0)
        CALL G2FILE(IDATA,IDATA,IDATA,IDATA,0,0,0,0,5,ISTATE)
        IF (ISTATE.GT.2)  GO TO 5
C
        CALL ENQRUN(KONT)
        IF (KONT(1).NE.0) GO TO 5
        IF (KONT(2).NE.0) GO TO 5
        GO TO 3
C
    5 CALL G3LINK(1,2,0,IDATA,RDATA)
      IF (MODE.NE.0) WRITE(KMESGO,204)
C
  204 FORMAT(1X,'++ GHOST-80 GRIDFILE PROCESSING ENDED ++',/)
C
      RETURN
      END
