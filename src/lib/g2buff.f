      SUBROUTINE G2BUFF(ICODE,LENGTH,IDATA,RDATA)
C
C          ------------------------------------------------
C          ROUTINE NO. (2002)   VERSION (A8.7)    07:NOV:96
C          ------------------------------------------------
C
C          THIS BUFFERS AND WRITES GRIDFILE DATA.
C
C
C          THE ARGUMENTS ARE AS FOLLOWS:
C
C          <ICODE>  THE GRID-80 FUNCTION CODE.
C          <LENGTH> GIVES THE DATA LENGTH AND TYPE:
C                   < 0, THE DATA IS INTEGER, OR
C                   > 0, THE DATA TYPE IS REAL.
C          [IDATA]  THE INTEGER DATA ARRAY.
C          [RDATA]  THE REAL DATA ARRAY.
C
C
      REAL    RDATA(*)
      INTEGER IDATA(*),IDUMMY
      LOGICAL SCRTCH,FIRST,ERRON
      LOGICAL RLDATA,EXCEED
C
      COMMON /T2BUFF/ IBUFFR(512),INDEXB,IBLOKL
      COMMON /T2COMM/ FIRST,IFILCO
      COMMON /T2IDEN/ IDGRID
      COMMON /T2INFO/ INFOFO(32),INFOPO(32)
      COMMON /T2INLO/ LNFOFO,LNFOPO
      COMMON /T2OPNA/ NAMEFO(32),NAMEPO(4)
      COMMON /T2OPNL/ LNFILN,LNPICN
      COMMON /T2PNUM/ NGPICS,LIMPIC
      COMMON /T2SAVE/ SCRTCH
      COMMON /T3CPAK/ NGCHI
      COMMON /T3ERRS/ ERRON,NUMERR
      COMMON /T3MACH/ NMCHI,NBITMC
      COMMON /T3NBYR/ NBYTR
      COMMON /T3SHUT/ K1ERR,K2ERR
C
      DATA IDUMMY /0/
C
C
      MAXIND= IBLOKL*NGCHI
C
C          THIS SECTION LOADS THE PICTURE HEADER DATA, BUT
C          ONLY WHEN THE BUFFER IS THE FIRST OF A PICTURE.
C
      IF (.NOT.FIRST) GO TO 2
      IF (ICODE.EQ.37) RETURN
C
      IBUFFR(1)= IDGRID+LNFOPO
      INDEXP= 0
      IF (LNFOPO.GT.0) INDEXP= ((LNFOPO-1)/NMCHI)+1
      IF (INDEXP.LE.0) GO TO 1
C
      DO 100 LOAD= 1,INDEXP
        IBUFFR(LOAD+2)= INFOPO(LOAD)
  100 CONTINUE
C
    1 INDEXB= (INDEXP+2)*NGCHI+1
      ISTATE= 0
      IF (SCRTCH.AND.ICODE.NE.34)
     &  CALL G2FILE(NAMEFO,NAMEPO,INFOFO,IBUFFR,LNFILN,0,IDUMMY,
     &              0,4,ISTATE)
      IF (ISTATE.GT.2) GO TO 901
C
C          WHEN THE BUFFER HAS INSUFFICIENT ROOM FOR THE NEW
C          OUTPUT DATA, THIS SECTION PADS IT OUT WITH 'NULL'
C          FUNCTIONS, THEN WRITES IT TO THE GRIDFILE. ('GREND'
C          AND 'NEW-PICTURE' FUNCTIONS ARE NOT HANDLED HERE).
C
    2 IF (ICODE.EQ.34.OR.ICODE.EQ.37.OR.
     &    ICODE.EQ.99.OR.ICODE.EQ.107) GO TO 5
C
      FIRST= .FALSE.
      LENDAT= IABS(LENGTH)
      IF (INDEXB+LENDAT+1.LE.MAXIND) GO TO 4
      IF (INDEXB.GT.MAXIND)          GO TO 3
C
      DO 200 ICLEAR= INDEXB,MAXIND
        CALL G4PUTK(IBUFFR,ICLEAR,8,NGCHI,0)
  200 CONTINUE
C
    3 CALL G2FILE(NAMEFO,NAMEPO,INFOFO,IBUFFR,
     &            LNFILN,LNPICN,LNFOFO,0,IFILCO,ISTATE)
      IF (ISTATE.GT.2) GO TO 902
C
      INDEXB= NGCHI*2+1
      IBUFFR(1)= IDGRID
      IFILCO= 2
C
C          THIS SECTION COPIES THE OUTPUT DATA INTO THE BUFFER.
C          FIRSTLY THE FUNCTION CODE IS ADDED, FOLLOWED BY THE
C          LENGTH OF THE DATA, THEN THE DATA ITSELF, WHICH MUST
C          BE PACKED INTO THE BUFFER USING <G4PUTK>. IN THE CASE
C          OF REAL NUMBERS, THE VALUES MUST FIRST BE UNPACKED
C          FROM THE INPUT DATA ARRAY USING SUBROUTINE <G4GETC>.
C
    4 CALL G4PUTK(IBUFFR,INDEXB,8,NGCHI,ICODE)
      INDEXB= INDEXB+1
      CALL G4PUTK(IBUFFR,INDEXB,8,NGCHI,LENDAT)
      INDEXB= INDEXB+1
      IF (LENGTH.EQ.0) RETURN
C
      RLDATA= .TRUE.
      IF (LENGTH.LT.0) RLDATA= .FALSE.
C
      DO 300 ISHIFT= 1,LENDAT
        IF (.NOT.RLDATA) KBYTE= MOD(IDATA(ISHIFT),256)
        IF (RLDATA)      CALL G4GETC(RDATA,ISHIFT,8,NBYTR,KBYTE)
        CALL G4PUTK(IBUFFR,INDEXB,8,NGCHI,KBYTE)
        INDEXB= INDEXB+1
  300 CONTINUE
      RETURN
C
C          'GREND' AND 'NEW-PICTURE' FUNCTIONS ARE HANDLED HERE.
C          THEY CAUSE THE DATA BUFFER TO BE WRITTEN IMMEDIATELY
C          (AFTER ANY NECESSARY PADDING WITH 'NULL' FUNCTIONS),
C          PROVIDED THE BUFFER IS NOT EMPTY. THE FUNCTION CODE
C          IS NOT INCLUDED. A 'GREND' CLOSES ALL OPEN GRIDFILES.
C          A SHUTOUT ENSURES THAT THE PICTURE LIMIT IS ENFORCED.
C
    5 IF (INDEXB.LE.NGCHI*2+1) GO TO 7
      IF (INDEXB.GT.MAXIND)    GO TO 6
C
      DO 400 ICLEAR= INDEXB,MAXIND
        CALL G4PUTK(IBUFFR,ICLEAR,8,NGCHI,0)
  400 CONTINUE
C
    6 CALL G2FILE(NAMEFO,NAMEPO,INFOFO,IBUFFR,
     &            LNFILN,LNPICN,LNFOFO,0,IFILCO,ISTATE)
      IF (ISTATE.GT.2) GO TO 902
    7 IF (ICODE.EQ.37) THEN
        INDEXB= NGCHI*2+1
      ELSE
        IFILCO= 1
        IF (.NOT.FIRST) NGPICS= NGPICS+1
C
        FIRST= .TRUE.
        EXCEED= (NGPICS.GT.LIMPIC.AND.LIMPIC.GT.0)
        IF (.NOT.EXCEED.AND.ICODE.NE.34) RETURN
C
        CALL G2FILE(NAMEFO,NAMEPO,INFOFO,IBUFFR,0,0,IDUMMY,0,5,ISTATE)
        IF (EXCEED)      GO TO 903
        IF (ISTATE.GT.2) GO TO 902
      ENDIF
C
        RETURN
C
C          THE FIRST PART CLOSES ALL OPEN FILES AND
C          THE SECOND PART OUTPUTS AN ERROR MESSAGE.
C
  901 CALL G2FILE(NAMEFO,NAMEPO,INFOFO,IBUFFR,0,0,IDUMMY,0,5,IERROR)
  902 NUMERR= ISTATE+1998
      IF (ERRON) CALL G2ERMS
      RETURN
C
C          THIS PART DOES A GRIDFILE SHUTOUT ON THE FIRST
C          OCCURRENCE OF THE GRIDFILE LIMIT BEING EXCEEDED.
C
  903 IF (K2ERR.NE.0) RETURN
C
      NUMERR= 2014
      CALL G2ERMS
      CALL G2SHUT(-1,2)
      RETURN
      END
