       SUBROUTINE G1CLSN(ICODE,LENGTH,IDATA,RDATA)
C
C          ------------------------------------------------
C          ROUTINE NO. (1019)   VERSION (A8.5B)   07:NOV:96
C          ------------------------------------------------
C
C          THIS OUTPUTS FUNCTIONS OF ALL CLASSES TO THE DECODE FILE.
C
C
C          THE ARGUMENTS ARE AS FOLLOWS:
C
C          <ICODE>  GIVES THE FUNCTION CODE (WHICH
C                   SHOULD BE IN THE RANGE 0 TO 255),
C          <LENGTH> GIVES THE DATA LENGTH (IN BYTES),
C          [IDATA]  IS THE INTEGER DATA ARRAY, AND
C          [RDATA]  IS THE ALTERNATIVE REAL DATA ARRAY.
C
C
      REAL      RDATA(*)
      INTEGER   IDATA(*),NAMEPI(16),IDUMMY(1)
      LOGICAL   INTDAT
      LOGICAL   PREADY
      CHARACTER KLASS0(14)*26,KLASS1(4)*26,KLASS2(17)*26,KLASS3(12)*26,
     &          KLASS4(4)*26,KLASS5(16)*26,KLASS7(17)*26,NOTDEF*26,
     &          KFDESC(85)*26,KSEPA*2,GRDNAM*128,PCNAME*16
C
      COMMON /T1CHAD/ KDISPI,KDISPO
      COMMON /T1DEBB/ PREADY,LINLIM,LINNUM,KNAML
      COMMON /T1DECC/ KFILEN(128)
      COMMON /T1PNUM/ NDPICS
      COMMON /T2OPNA/ NAMEFO(32),NAMEPO(4)
      COMMON /T2OPNL/ LNFILN,LNPICN
      COMMON /T3MACH/ NMCHI,NBITMC
      COMMON /T3NBYR/ NBYTR
C
      EQUIVALENCE (KLASS0(1),KFDESC(1)),(KLASS1(1),KFDESC(15)),
     &            (KLASS2(1),KFDESC(19)),(KLASS3(1),KFDESC(36)),
     &            (KLASS4(1),KFDESC(48)),(KLASS5(1),KFDESC(52)),
     &            (KLASS7(1),KFDESC(68)),(NOTDEF,KFDESC(85))
C
      SAVE KFDESC
      DATA KLASS0 /'POINT PLOT               (',
     &             'MOVE PLOT POSITION       (',
     &             'POLYLINE                 (',
     &             'POLYMARKLINE             (',
     &             'POLYMARKER               (',
     &             'SHORT-VECTOR SCALING     (',
     &             'SHORT-VECTOR STRING      (',
     &             'CLOSED CONIC             (',
     &             'CONIC ARC                (',
     &             'CURVE TYPE               (',
     &             'CURVE-DRAWING METHOD     (',
     &             'PARTIAL CURVE            (',
     &             'COMPLETE CURVE           (',
     &             'WINDOW-VECTOR MODE       ('/
      DATA KLASS1 /'END OF PICTURE INSERT    (',
     &             'END OF GRAPHICAL OUTPUT  (',
     &             'START OF INSERT OR FRAME (',
     &             'END OF SINGLE FRAME      ('/
      DATA KLASS2 /'CHAR. HARDWARE MODE      (',
     &             'CHARACTER FONT           (',
     &             'CHAR. MAGNIFICATION      (',
     &             'STRING ORIENTATION       (',
     &             'CHARACTER ORIENTATION    (',
     &             'ITALIC MODE              (',
     &             'UNDERLINE NUMBER         (',
     &             'CHARACTER OBLATENESS     (',
     &             'MARKER CHARACTER         (',
     &             'CHARACTER SPACE          (',
     &             'CHARACTER STRING         (',
     &             'CHARACTER MOVE           (',
     &             'CHAR. WINDOW MODE        (',
     &             'CHAR. MASKING MODE       (',
     &             'STACK CHAR. DEFINITIONS  (',
     &             'REDEFINE CHARACTER       (',
     &             'JUSTIFICATION TYPE       ('/
      DATA KLASS3 /'OPEN DEVICE CHANNEL      (',
     &             'CLOSE DEVICE CHANNEL     (',
     &             'PROMPTED DEVICE ERASE    (',
     &             'LINE THICKNESS           (',
     &             'OBSOLETE FUNCTION        (',
     &             'LINE PATTERN             (',
     &             'LINE HARDWARE MODE       (',
     &             'LINE BLINK MODE          (',
     &             'LINE COLOUR NUMBER       (',
     &             'FLUSH ALL PENDING OUTPUT (',
     &             'UNPROMPTED DEVICE ERASE  (',
     &             'DEVICE RESOLUTION        ('/
      DATA KLASS4 /'SELECT OUTPUT BUFFER     (',
     &             'SELECT SYSTEM BUFFER     (',
     &             'UNLOAD OUTPUT BUFFER     (',
     &             'ERASE OUTPUT BUFFER      ('/
      DATA KLASS5 /'DEFINE COLOUR NUMBER     (',
     &             'BACKGROUND COLOUR NUMBER (',
     &             'FILL-AREA COLOUR NUMBER  (',
     &             'FILL CURRENT POLYGON     (',
     &             'CROSS-HATCH ANGLE        (',
     &             'CROSS-HATCH PITCH        (',
     &             'CROSS-HATCH OFFSET       (',
     &             'CROSS-HATCH LINE PATTERN (',
     &             'CROSS-HATCH PHASE        (',
     &             'CROSS-HATCH COLOUR       (',
     &             'CROSS-HATCH TYPE         (',
     &             'PATTERN DEFINITION NO.   (',
     &             'CROSS-HATCH FLAG         (',
     &             'PATTERN COPY             (',
     &             'CROSS-HATCH START POINT  (',
     &             'SHADING OPTION FLAG      ('/
      DATA KLASS7 /'LINEAR-LINEAR MAP        (',
     &             'LINEAR-LOG. MAP          (',
     &             'LOG.-LINEAR MAP          (',
     &             'LOG.-LOG. MAP            (',
     &             'VECTOR WINDOW            (',
     &             'MASK AREA                (',
     &             'MASK LEVEL               (',
     &             'X-AXIS SCALE FACTOR      (',
     &             'Y-AXIS SCALE FACTOR      (',
     &             'OBSOLETE FUNCTION        (',
     &             'OBSOLETE FUNCTION        (',
     &             'PICTURE ROTATION         (',
     &             'TRANS. REFERENCE POINT   (',
     &             'TRANSFORMATION INDENT    (',
     &             'TRANSFORMATION UNDENT    (',
     &             'CLIP-AREA TRANS. MODE    (',
     &             'PICTURE TRANS. MODE      ('/
      DATA NOTDEF /'UNDEFINED FUNCTION       ('/
      DATA IDUMMY /0/, KSEPA /', '/, MAXMES /85/
C
C
C          THE DATA TYPE IS FOUND FROM THE CODE.
C
      INTDAT= .TRUE.
      IF (ICODE.GE.  2.AND.ICODE.LE.  6) INTDAT= .FALSE.
      IF (ICODE.GE.  8.AND.ICODE.LE.  9) INTDAT= .FALSE.
      IF (ICODE.GE. 12.AND.ICODE.LE. 13) INTDAT= .FALSE.
      IF (ICODE.GE. 68.AND.ICODE.LE. 69) INTDAT= .FALSE.
      IF (ICODE.EQ. 72.OR .ICODE.EQ. 74) INTDAT= .FALSE.
      IF (ICODE.EQ.161.OR .ICODE.EQ.165) INTDAT= .FALSE.
      IF (ICODE.GE.225.AND.ICODE.LE.230) INTDAT= .FALSE.
      IF (ICODE.GE.232.AND.ICODE.LE.237) INTDAT= .FALSE.
      IF (ICODE.EQ.239)                  INTDAT= .FALSE.
C
C          IF A NEW PICTURE IS BEGUN, PICTURE READY IS SET.
C
      IF (ICODE.NE.99.AND.ICODE.NE.107) GO TO 1
C
      PREADY= .TRUE.
      RETURN
C
C          IF A NEW PICTURE IS READY, A NEW LISTING PAGE IS BEGUN
C          AND THE PICTURE IDENTIFIERS ARE WRITTEN FIRST OF ALL.
C
    1 IF (.NOT.PREADY)  GO TO 5
      IF (ICODE.EQ.34) GO TO 5
C
      WRITE(KDISPO,201)
  201 FORMAT(1H1)
      LINNUM= 1
C
C          IF THE FILE NAME HAS CHANGED SINCE LAST
C          TIME, THE NEW NAME IS WRITTEN OUT HERE.
C
C          THIS SECTION CHECKS FOR A CHANGE OF NAME.
C
      IF (KNAML.NE.LNFILN) GO TO 2
      LOOK2= 1
      DO 100 LOOK= 1,LNFILN
        CALL G4GETK(NAMEFO,LOOK, NBITMC,NMCHI,JCHAR)
        CALL G4GETK(KFILEN,LOOK2,NBITMC,NMCHI,KCHAR)
        LOOK2= LOOK2+NMCHI
        IF (JCHAR.NE.KCHAR) GO TO 2
  100 CONTINUE
      GO TO 3
C
C          THIS SECTION STORES THE NEW NAME AND WRITES IT.
C
    2 KNAML= LNFILN
      LOAD2= 1
      DO 200 LOAD= 1,KNAML
        CALL G4GETK(NAMEFO,LOAD, NBITMC,NMCHI,JCHAR)
        CALL G4PUTK(KFILEN,LOAD2,NBITMC,NMCHI,JCHAR)
        GRDNAM(LOAD:LOAD)= CHAR(JCHAR)
        LOAD2= LOAD2+NMCHI
  200 CONTINUE
      WRITE(KDISPO,202) (GRDNAM(JCHAR:JCHAR), JCHAR= 1,KNAML)
  202 FORMAT(///,1X,'The GRIDfile name is: ',50A1)
      LINNUM= LINNUM+4
C
C          THIS SECTION WRITES THE PICTURE NAME AND NUMBER.
C
    3 IF (LNPICN.LE.0) GO TO 4
      LOAD2= 1
      DO 300 LOAD= 1,LNPICN
        CALL G4GETK(NAMEPO,LOAD, NBITMC,NMCHI,JCHAR)
        CALL G4PUTK(NAMEPI,LOAD2,NBITMC,NMCHI,JCHAR)
        PCNAME(LOAD:LOAD)= CHAR(JCHAR)
        LOAD2= LOAD2+NMCHI
  300 CONTINUE
      WRITE(KDISPO,203) (PCNAME(JCHAR:JCHAR), JCHAR= 1,LNPICN)
  203 FORMAT(//,1X,'The new picture name is: ',16A1)
      LINNUM= LINNUM+3
C
    4 WRITE(KDISPO,204) NDPICS
  204 FORMAT(/,1X,'Picture no. ',I3,'...')
      WRITE(KDISPO,205)
  205 FORMAT(//,
     &       1X,'    FUNCTION                          ARGUMENT',/,
     &       1X,'  CODE    DESCRIPTION              LENGTH  VALUE(S)',
     &       //)
      LINNUM= LINNUM+8
C
      NDPICS= NDPICS+1
      PREADY= .FALSE.
C
C          THIS PART PROVIDES NORMAL FUNCTION/DATA OUTPUT.
C
    5 IFUNC= MOD(IABS(ICODE),256)
      KLASS= IFUNC/32
      IFUNCO= ICODE-32*KLASS
      LENA= IABS(LENGTH)
      IF (.NOT.INTDAT) LENA= LENA/NBYTR
C
      LINE= MAXMES
      IF (KLASS.EQ.0.AND.IFUNCO.LE.14) LINE= IFUNC
      IF (KLASS.EQ.1.AND.IFUNCO.LE. 4) LINE= IFUNCO+14
      IF (KLASS.EQ.2.AND.IFUNCO.LE.17) LINE= IFUNCO+18
      IF (KLASS.EQ.3.AND.IFUNCO.LE.12) LINE= IFUNCO+35
      IF (KLASS.EQ.4.AND.IFUNCO.LE. 4) LINE= IFUNCO+47
      IF (KLASS.EQ.5.AND.IFUNCO.LE.16) LINE= IFUNCO+51
      IF (KLASS.EQ.7.AND.IFUNCO.LE.17) LINE= IFUNCO+67
C
      ITYPE= 2
      IF (INTDAT)     ITYPE= 1
      IF (LENA.EQ.0)  ITYPE= 0
      IF (LINE.EQ.MAXMES) ITYPE= 3
C
C          IF THE PAGE IS FULL, A NEW PAGE AND HEADER ARE FIRST DONE. A
C          MULTI-LINE FUNCTION IS NOT ALLOWED TO BEGIN ON THE LAST LINE.
C
      IF (LINNUM.LT.LINLIM)                              GO TO 6
      IF (LINNUM.EQ.LINLIM.AND.ITYPE.EQ.1.AND.LENA.LE.4) GO TO 6
      IF (LINNUM.EQ.LINLIM.AND.ITYPE.EQ.2.AND.LENA.LE.2) GO TO 6
C
      WRITE(KDISPO,201)
      WRITE(KDISPO,205)
      LINNUM= 7
C
    6 LENO= LENA
      LINNUM= LINNUM+1
      IF (ITYPE.NE.0) GO TO 7
C
C          THIS PART WRITES ARGUMENTLESS FUNCTIONS.
C
      WRITE(KDISPO,206) KLASS,IFUNCO,ICODE,
     &                  KFDESC(LINE),LENA
  206 FORMAT(1X,I1,1X,I2,1X,I3,2X,A26,I2,' )')
      GO TO 12
C
C          THIS PART WRITES INTEGER-ARGUMENT FUNCTIONS.
C
    7 IF (ITYPE.NE.1) GO TO 9
C
      IF (LENO.GT.4) LENO= 4
      IF (LENO.EQ.1)
     &  WRITE(KDISPO,209) KLASS,IFUNCO,ICODE,
     &                    KFDESC(LINE),LENA,IDATA(1)
      IF (LENO.NE.1)
     &  WRITE(KDISPO,209) KLASS,IFUNCO,ICODE,
     &                    KFDESC(LINE),LENA,
     &                    IDATA(1),(KSEPA,IDATA(IOUT),IOUT= 2,LENO)
  209 FORMAT(1X,I1,1X,I2,1X,I3,2X,A26,I2,'I)',
     &       '  ',I5,3(A2,I5))
C
C          THIS PART COMPLETES THE INTEGER ARGUMENT LIST.
C          A NEW PAGE AND HEADER ARE DONE IF NECESSARY.
C
      NLINES= (LENA-1)/4
      IF (NLINES.LE.0) GO TO 12
C
      NMISS= 4*(NLINES+1)-LENA
      ICONT= 2
      DO 500 LINE= 1,NLINES
        IF (LINNUM.LE.LINLIM) GO TO 8
        WRITE(KDISPO,201)
        WRITE(KDISPO,205)
        LINNUM= 7
C
    8   ICONT= ICONT+4
        ISTRT= ICONT-1
        ISTOP= ICONT+2
        IF (LINE.EQ.NLINES) ISTOP= ISTOP-NMISS
        IF (ISTOP.GE.ICONT)
     &    WRITE(KDISPO,210) IDATA(ISTRT),
     &                      (KSEPA,IDATA(IOUT), IOUT= ICONT,ISTOP)
        IF (ISTOP.LT.ICONT)
     &    WRITE(KDISPO,210) IDATA(ISTRT)
  210   FORMAT(43X,I5,3(A2,I5))
        LINNUM= LINNUM+1
  500 CONTINUE
      GO TO 12
C
C          THIS PART WRITES REAL-ARGUMENT FUNCTIONS.
C
    9 IF (ITYPE.NE.2) GO TO 11
C
      IF (LENO.GT.2) LENO= 2
      IF (LENO.EQ.1)
     &  WRITE(KDISPO,207) KLASS,IFUNCO,ICODE,
     &                    KFDESC(LINE),LENA,RDATA(1)
      IF (LENO.GT.1)
     &  WRITE(KDISPO,207) KLASS,IFUNCO,ICODE,
     &                    KFDESC(LINE),LENA,
     &                    RDATA(1),(KSEPA,RDATA(IOUT), IOUT= 2,LENO)
  207 FORMAT(1X,I1,1X,I2,1X,I3,2X,A26,I2,'R)',
     &       '  ',1PE15.8,A2,1PE15.8)
C
C          THIS PART COMPLETES THE REAL ARGUMENT LIST.
C          A NEW PAGE AND HEADER ARE DONE IF NECESSARY.
C
      NLINES= (LENA-1)/2
      IF (NLINES.LE.0) GO TO 12
C
      NMISS= 2*(NLINES+1)-LENA
      ICONT= 2
      DO 400 LINE= 1,NLINES
        IF (LINNUM.LE.LINLIM) GO TO 10
        WRITE(KDISPO,201)
        WRITE(KDISPO,205)
        LINNUM= 7
C
   10   ICONT= ICONT+2
        ISTRT= ICONT-1
        ISTOP= ICONT
        IF (LINE.EQ.NLINES) ISTOP= ISTOP-NMISS
        IF (ISTOP.GE.ICONT)
     &    WRITE(KDISPO,208) RDATA(ISTRT),
     &                      (KSEPA,RDATA(IOUT), IOUT= ICONT,ISTOP)
        IF (ISTOP.LT.ICONT)
     &    WRITE(KDISPO,208) RDATA(ISTRT)
  208   FORMAT(43X,1PE15.8,A2,1PE15.8)
        LINNUM= LINNUM+1
  400 CONTINUE
      GO TO 12
C
C          THIS PART WRITES UNDEFINED FUNCTIONS.
C
   11 WRITE(KDISPO,211) KLASS,IFUNCO,ICODE,
     &                  KFDESC(LINE),LENA
  211 FORMAT(1X,I1,1X,I2,1X,I3,2X,A26,I2,'B)')
C
C          IF THE FUNCTION IS A 'GREND', THE OUTPUT FILE IS CLOSED.
C
   12 IF (ICODE.EQ.34) CALL G1DVIO(2,IDUMMY,1)
C
      RETURN
      END
