      SUBROUTINE G1CMLN
C
C          ------------------------------------------------
C          ROUTINE NO. (1029)   VERSION (A8.1A)   17:DEC:91
C          ------------------------------------------------
C
C          THIS READS PARAMETERS OFF THE COMMAND LINE AND STORES
C          THEM, TOGETHER WITH ANY ASSOCIATED DATA, IN THE
C          COMMON BLOCK T1CMLN.
C          (THIS IS THE BERKELEY UNIX VERSION).
C
C          THE COMMAND LINE FORMAT IS AS FOLLOWS:
C
C          COMMAND [ -string[ value]][ -string[ value]]...[GRIDfile name]
C
C
C          THE FOLLOWING STRINGS AND VALUES HAVE BEEN ALLOCATED:
C
C           1) int            INTERACTIVE MODE
C           2) glan           USE LANDSCAPE MODE
C           3) gpor           USE PORTRAIT MODE
C           4) ght  <int>     HEIGHT OF GRAPHICS WINDOW
C           5) gwid <int>     WIDTH OF WINDOW
C           6) gxor <int>     X COORDINATE OF WINDOW ORIGIN
C           7) gyor <int>     Y COORDINATE OF WINDOW ORIGIN
C          25) grfl <string>  NAME OF GRIDFILE
C          26) gfil <string>  NAME OF OUTPUT FILE            (CHCMND(1))
C          27) gtit <string>  TITLE OF WINDOW                (CHCMND(2))
C          28) gher <string>  HERSHEY FILE DIRECTORY         (CHCMND(3))
C
C
      INTEGER   ICMFLG(35)
      LOGICAL   ERRON
      CHARACTER PARAM(71)*128,STR(35)*4
      CHARACTER CHCMND*128
C
      COMMON /T1CMLC/ CHCMND(10)
      COMMON /T1CMLN/ NMFILE(32),LNFILE,ICMND(35,2)
      COMMON /T3ERRS/ ERRON,NUMERR
      COMMON /T3FILL/ LENDEF,LENSCR
      COMMON /T3FILN/ NAMDEF(32),NAMSCR(32)
      COMMON /T3MACH/ NMCHI,NBITMC
C
      DATA IENDCH /33/
      DATA ICMFLG /0,0,0,1,1,
     &             1,1,0,0,0,
     &             0,0,0,0,0,
     &             0,0,0,0,0,
     &             0,0,0,0,1,
     &             1,1,1,0,0,
     &             0,0,0,0,0/
      DATA STR /'int ','glan','gpor','ght ','gwid',
     &          'gxor','gyor','    ','    ','    ',
     &          '    ','    ','    ','    ','    ',
     &          '    ','    ','    ','    ','    ',
     &          '    ','    ','    ','    ','grfl',
     &          'gfil','gtit','gher','    ','    ',
     &          '    ','    ','    ','    ','    '/
C
C          RESET THE COMMON BLOCK ARRAYS.
C
      DO 100 ISET= 1,32
        NMFILE(ISET)= NAMDEF(ISET)
  100 CONTINUE
C
      LNFILE= LENDEF+1
      CALL G4PUTK(NMFILE,LNFILE,NBITMC,NMCHI,IENDCH)
C
      DO 200 ISET= 1,35
        ICMND(ISET,1)= 0
        ICMND(ISET,2)= 0
  200 CONTINUE
C
C          THE NUMBER OF ARGUMENTS INCLUDING THE DATA ARE FIRST
C          FETCHED. THE ARGUMENTS ARE THEN READ.
C
      CALL GETARG(0,CHCMND(10))
      NARGS= IARGC()
      IF (NARGS.EQ.0) RETURN
      IF (NARGS.GT.71) NARGS= 71
C
      DO 300 ILOAD= 1,NARGS
        CALL GETARG(ILOAD,PARAM(ILOAD))
  300 CONTINUE
C
C          THE LINE IS THEN PARSED.
C
      KPARAM= 0
    1 KPARAM= KPARAM+1
      IF (KPARAM.GT.NARGS) RETURN
      IF (PARAM(KPARAM)(1:1).NE.'-') GO TO 7
C
      DO 400 ICH= 1,35
        IF (PARAM(KPARAM)(2:5).EQ.STR(ICH)) GO TO 2
C
  400 CONTINUE
C
      GO TO 1
C
    2 ICMND(ICH,1)= 1
      IF (ICH.EQ.1) CALL G4PUTK(NMFILE,1,NBITMC,NMCHI,IENDCH)
      IF (ICMFLG(ICH).EQ.0) GO TO 1
C
      KPARAM= KPARAM+1
      IF (KPARAM.GT.NARGS) RETURN
      IF (PARAM(KPARAM)(1:1).EQ.'-') GO TO 901
      IF (ICH.EQ.25) GO TO 7
      IF (ICH.GE.26.AND.ICH.LE.35) GO TO 5
C
C          DECODE AN INTEGER ARGUMENT.
C
      KCH= 1
      NUM= 0
    3 ICH2= ICHAR(PARAM(KPARAM)(KCH:KCH))
      IF (ICH2.LT.48.OR.ICH2.GT.57) GO TO 4
C
      NUM= NUM*10+ICH2-48
      KCH= KCH+1
      GO TO 3
C
    4 ICMND(ICH,2)= NUM
      GO TO 1
C
C          DECODE A STRING ARGUMENT.
C
    5 CHCMND(ICH-25)= PARAM(KPARAM)
C
      DO 500 ISCAN= 128,1,-1
        IF (PARAM(KPARAM)(ISCAN:ISCAN).NE.' ') GO TO 6
  500 CONTINUE
C
    6 ICMND(ICH,2)= ISCAN
      GO TO 1
C
C          FILENAME FOUND.
C
    7 LNFILE= LENSTR(PARAM(KPARAM))+1
C
      DO 600 ILOAD= 1,LNFILE-1
        ICH= ICHAR(PARAM(KPARAM)(ILOAD:ILOAD))
        CALL G4PUTK(NMFILE,ILOAD,NBITMC,NMCHI,ICH)
  600 CONTINUE
C
      CALL G4PUTK(NMFILE,LNFILE,NBITMC,NMCHI,IENDCH)
      GO TO 1
C
  901 NUMERR= 1008
      CALL G1ERMS
      STOP
      END
