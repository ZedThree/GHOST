      SUBROUTINE TRAND(KIND)
C
C          ------------------------------------------------
C          ROUTINE NO. (5003)   VERSION (A8.6)    11:OCT:90
C          ------------------------------------------------
C
C          THIS READS A TRANGRID FILE, RECODES IT INTO
C          GRID-80 FORMAT, AND THEN PASSES IT ON TO THE
C          POST-PROCESSOR MODULE VIA SUBROUTINE <G3LINK>.
C
C
C          THE INPUT ARGUMENT:
C
C          <KIND> SELECTS THE TYPE OF ACTION:
C                 = 1, THIS ACTS AS A USER UTILITY,
C                 = 2, THIS ACTS AS A SYSTEM UTILITY
C                      (E.G. NO TITLES ARE WRITTEN).
C
C
      REAL      RDATA(255)
      INTEGER   IDATA(255),KONT(2)
      LOGICAL   TEROUT
      LOGICAL   SHIFT0
C
      COMMON /T0CANG/ STANG0,CRANG0
      COMMON /T0CATT/ IUNDL0,ITAL0
      COMMON /T0CDIM/ MAGN0,OBLAT0
      COMMON /T0CFON/ KFONT0
      COMMON /T0CSPA/ X1CHR0,X2CHR0,Y1CHR0,Y2CHR0
      COMMON /T0CVIS/ KWIND0,KMASK0
      COMMON /T0DEVS/ KCHAN0(5),IRESL0
      COMMON /T0HRDC/ KHRDW0
      COMMON /T0HRDL/ LHRDW0
      COMMON /T0KBAC/ KOLBA0
      COMMON /T0KTAB/ REDCO0(255),GRNCO0(255),BLUCO0(255),NCOLS0
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
      COMMON /T2OPNA/ NAMEFO(32),NAMEPO(4)
      COMMON /T2OPNL/ LNFILN,LNPICN
      COMMON /T2INFO/ INFOFO(32),INFOPO(32)
      COMMON /T2INLO/ LNFOFO,LNFOPO
      COMMON /T2PNUM/ NGPICS,LIMPIC
      COMMON /T3LIMS/ IMAXI,RMAXI,RMINI
      COMMON /T3CHAM/ KMESGI,KMESGO
      COMMON /T3NBYR/ NBYTR
      COMMON /T3MACH/ NMCHI,NBITMC
      COMMON /T5TBUF/ IFUNIB(257)
      COMMON /T5TCON/ MAXEXP,MINEXP,RMAXMA,RMINMA
      COMMON /T5TERR/ INERR,TEROUT
      COMMON /T5TINP/ KTRNMI,KTRNDI,INPBUF(26),INBUFP,INLINE
C
C
C          INITIALISATION IS DONE FIRST, THEN COMPLETE
C          INSTRUCTIONS ARE READ FROM THE TRANGRID FILE.
C          IF AN I/O ERROR IS ENCOUNTERED, <TRAND> STOPS.
C
      IF (KIND.NE.2) CALL G3INIT(1)
      IF (KIND.EQ.2) CALL G3INIT(2)
C
      LIMPIC= 0
      BIGLOG= ALOG10(RMAXI)
      SMALOG= ALOG10(RMINI)
      MAXEXP= INT(BIGLOG)+1
      MINEXP= INT(SMALOG)
      RMAXMA= 10.0**(BIGLOG-FLOAT(MAXEXP)-1.0)
      RMINMA= 10.0**(SMALOG-FLOAT(MINEXP))
C
C          (THE INPUT BUFFER POINTER IS SET TO CAUSE AN INITIAL READ).
C
      INBUFP= 100
      INERR= 0
      INLINE= 0
C
      IF (KIND.NE.2) WRITE(KMESGO,201)
  201 FORMAT(1X,'++ GHOST-80 TRANGRID DECODER ++')
C
    1   CALL ENQRUN(KONT)
        IF (KONT(1).NE.0) GO TO 46
        IF (KONT(2).NE.0) GO TO 46
C
        CALL G5LODI
        IF (INERR.NE.0)   GO TO 46
C
        ICODE= IFUNIB(1)
        ICLASS= ICODE/32
        IFUNCO= ICODE-32*ICLASS
        LENGTH= IFUNIB(2)
C
C          THE TYPE OF INSTRUCTION IS THEN DECODED; THE POSSIBILITIES
C          ARE: INTEGER-DATA, REAL-DATA, NO-DATA, OR SPECIAL FUNCTION.
C
        IF (ICODE.GE.59.AND.ICODE.LE.63) GO TO 41
        IF (LENGTH.GE.256) GO TO 21
C
C          THIS SECTION DEALS WITH INTEGER-DATA OR NO-DATA INSTRUCTIONS.
C
        IF (LENGTH.LE.0) GO TO 2
C
        DO 100 ICOPY= 1,LENGTH
          IDATA(ICOPY)= IFUNIB(ICOPY+2)
  100   CONTINUE
        LENGTH= -LENGTH
C
    2   CALL G3LINK(ICLASS,IFUNCO,LENGTH,IDATA,RDATA)
C
C          SAVE ATTRIBUTES IN THE PRE-PROCESSOR COMMON BLOCKS.
C
        IF (ICODE.LT.65) GO TO 1
        IF (ICODE.GT.78) GO TO 11
C
        LABEL= ICODE-64
        GO TO (3,4,5,1,1,6,7,1,8,1,1,1,9,10), LABEL
C
    3   KHRDW0= IDATA(1)
        GO TO 1
C
    4   KFONT0= IDATA(1)
        GO TO 1
C
    5   MAGN0= IDATA(1)
        GO TO 1
C
    6   ITAL0= IDATA(1)
        GO TO 1
C
    7   IUNDL0= IDATA(1)
        GO TO 1
C
    8   MARKC0= IDATA(1)
        GO TO 1
C
    9   KWIND0= IDATA(1)
        GO TO 1
C
   10   KMASK0= IDATA(1)
        GO TO 1
C
   11   IF (ICODE.LT.100) GO TO 1
        IF (ICODE.GT.108) GO TO 17
C
        LABEL= ICODE-99
        GO TO (12,1,13,14,1,15,1,1,16), LABEL
C
   12   ITHIK0= IDATA(1)
        GO TO 1
C
   13   MARKA0= IDATA(1)
        MISSA0= IDATA(2)
        MARKB0= IDATA(3)
        MISSB0= IDATA(4)
        GO TO 1
C
   14   LHRDW0= IDATA(1)
        GO TO 1
C
   15   KOLIN0= IDATA(1)
        GO TO 1
C
   16   IRESL0= IDATA(1)
        GO TO 1
C
   17   IF (ICODE.NE.162) GO TO 18
C
        KOLBA0= IDATA(1)
        GO TO 1
C
   18   IF (ICODE.NE.231) GO TO 19
C
        MSKLV0= IDATA(1)
        GO TO 1
C
   19   IF (ICODE.NE.240) GO TO 20
C
        KLIPM0= IDATA(1)
        GO TO 1
C
   20   IF (ICODE.NE.241) GO TO 1
C
        MTRAN0= IDATA(1)
        GO TO 1
C
C          THIS SECTION DEALS WITH REAL-DATA INSTRUCTIONS.
C
   21   LENGTH= LENGTH-256
        NREALS= 0
        IOFFST= 3
C
   22     IF (LENGTH+3.LE.IOFFST) GO TO 26
          NREALS= NREALS+1
C
C          IF THE FIRST BYTE IS ZERO, THE NUMBER IS A ONE-TRIPLET ZERO.
C
          M1= IFUNIB(IOFFST)
          IF (M1.EQ.0) GO TO 25
C
C          THIS PART DECODES A FULL 4-TRIPLET VALUE.
C
          IEXPON= IFUNIB(IOFFST+3)
          RMANTA= ISIGN(1,M1)*(IABS(M1)*1.0E-2
     &                        +IFUNIB(IOFFST+1)*1.0E-5
     &                        +IFUNIB(IOFFST+2)*1.0E-8)
C
          IF (IEXPON.LT.MAXEXP.AND.IEXPON.GT.MINEXP) GO TO 24
          IF (IEXPON.GE.MAXEXP) GO TO 23
C
C          IF UNDERFLOW WILL OCCUR, ZERO VALUE IS SET INSTEAD.
C
          IF (IEXPON.GE.MINEXP.AND.ABS(RMANTA).GE.RMINMA) GO TO 24
          RDATA(NREALS)= 0.0
          IOFFST= IOFFST+4
          GO TO 22
C
C          IF OVERFLOW WILL OCCUR, THE LARGEST VALUE IS SET INSTEAD.
C
   23     IF (IEXPON.LE.MAXEXP.AND.ABS(RMANTA).LE.RMAXMA) GO TO 24
          IF (RMANTA.GT.0.0) RDATA(NREALS)=  RMAXI
          IF (RMANTA.LT.0.0) RDATA(NREALS)= -RMAXI
          IOFFST= IOFFST+4
          GO TO 22
C
C          THE CURRENT VALUE IS THEN PLACED IN [RDATA].
C
   24     RDATA(NREALS)= (ISIGN(1,M1)*(IABS(M1)*10.0**(IEXPON+6)
     &                   +IFUNIB(IOFFST+1)*10.0**(IEXPON+3)
     &                   +IFUNIB(IOFFST+2)*10.0**IEXPON))/1.0E8
          IOFFST= IOFFST+4
          GO TO 22
C
C          THIS SECTION DEALS WITH A ZERO NUMBER.
C
   25     RDATA(NREALS)= 0.0
          IOFFST= IOFFST+1
          GO TO 22
C
C          AFTER ALL THE REAL VALUES HAVE BEEN CONVERTED, THEY
C          ARE PASSED ON TO <G3LINK>; IF THE NUMBER OF VALUES
C          IS GREATER THAN CAN BE TAKEN IN ONE GO, THE CALL IS
C          REPEATED, BUT REAL VALUES ARE ALWAYS KEPT IN PAIRS.
C
   26     MAXRLS= 255/NBYTR
          IF (NREALS.LE.MAXRLS) GO TO 27
C
          NPART= 2*(MAXRLS/2)
          CALL G3LINK(ICLASS,IFUNCO,NPART*NBYTR,IDATA,RDATA)
          NLEFT= NREALS-NPART
C
          DO 200 ITO= 1,NLEFT
            IFROM= NPART+ITO
            RDATA(ITO)= RDATA(IFROM)
  200     CONTINUE
          NREALS= NLEFT
          GO TO 26
C
   27   CALL G3LINK(ICLASS,IFUNCO,NREALS*NBYTR,IDATA,RDATA)
C
C          SAVE ATTRIBUTES IN THE PRE-PROCESSOR COMMON BLOCKS.
C
        IF (ICODE.LT.68) GO TO 1
        IF (ICODE.GT.74) GO TO 32
C
        LABEL= ICODE-67
        GO TO (28,29,1,1,30,1,31), LABEL
C
   28   STANG0= RDATA(1)
        GO TO 1
C
   29   CRANG0= RDATA(1)
        GO TO 1
C
   30   OBLAT0= RDATA(1)
        GO TO 1
C
   31   X1CHR0= RDATA(1)
        X2CHR0= RDATA(2)
        Y1CHR0= RDATA(3)
        Y2CHR0= RDATA(4)
        GO TO 1
C
   32   IF (ICODE.NE.161) GO TO 33
C
        INDEX= RDATA(1)+0.5
        REDCO0(INDEX)= RDATA(2)
        GRNCO0(INDEX)= RDATA(3)
        BLUCO0(INDEX)= RDATA(4)
        IF (NCOLS0.LT.INDEX) NCOLS0= INDEX
        GO TO 1
C
   33   IF (ICODE.LT.225) GO TO 1
        IF (ICODE.GT.237) GO TO 1
C
        LABEL= ICODE-224
        GO TO (34,34,34,34,35,36,1,37,38,1,1,39,40), LABEL
C
   34   X1MAP0= RDATA(1)
        X2MAP0= RDATA(2)
        Y1MAP0= RDATA(3)
        Y2MAP0= RDATA(4)
        MAPNO0= LABEL
        XPLOT0= X1MAP0
        YPLOT0= Y1MAP0
        VRPICX= XPLOT0
        VRPICY= YPLOT0
        GO TO 1
C
   35   X1WND0= RDATA(1)
        X2WND0= RDATA(2)
        Y1WND0= RDATA(3)
        Y2WND0= RDATA(4)
        XPLOT0= X1WND0
        YPLOT0= Y1WND0
        VRPICX= XPLOT0
        VRPICY= YPLOT0
        GO TO 1
C
   36   MSKLV0= MSKLV0+1
        X1MSK0(MSKLV0)= RDATA(1)
        X2MSK0(MSKLV0)= RDATA(2)
        Y1MSK0(MSKLV0)= RDATA(3)
        Y2MSK0(MSKLV0)= RDATA(4)
        GO TO 1
C
   37   SCALX0= RDATA(1)
        VRPICX= XPLOT0
        VRPICY= YPLOT0
        GO TO 1
C
   38   SCALY0= RDATA(1)
        VRPICX= XPLOT0
        VRPICY= YPLOT0
        GO TO 1
C
   39   ROTAT0= RDATA(1)
        VRPICX= XPLOT0
        VRPICY= YPLOT0
        GO TO 1
C
   40   RDEVX0= RDATA(1)
        RDEVY0= RDATA(1)
        GO TO 1
C
C          THIS SECTION DEALS WITH THE SPECIAL CLASS-1 TRANGRID
C          INSTRUCTIONS, FUNCTIONS (DECIMAL) 59 TO 63 INCLUSIVE.
C
   41   ITYPE= ICODE-58
        GO TO (42,43,44,45,46), ITYPE
C
C          THIS SECTION DEALS WITH FILENAMES (FUNCTION 59).
C          <G5NEWF> SETS CONDITIONS FOR THE NEW GRIDFILE.
C
   42   CALL G3LINK(3,3,0,IDATA,RDATA)
C
        CALL G5NEWF
        GO TO 1
C
C          THIS SECTION DEALS WITH FILE INFORMATION (FUNCTION 60).
C          IF NO INFORMATION HAS BEEN SUPPLIED, NOTHING IS DONE.
C
   43   LNFOFO= 0
        IF (LENGTH.LE.0) GO TO 1
        LNFOFO= LENGTH
C
        DO 400 ICOPY= 1,LENGTH
          CALL G4BACO(IFUNIB(ICOPY+2),ICHAR)
          CALL G4PUTK(INFOFO,ICOPY,NBITMC,NMCHI,ICHAR)
  400   CONTINUE
        GO TO 1
C
C          THIS SECTION DEALS WITH A PICTURE NAME (FUNCTION 61).
C          IT IS COPIED TO THE CURRENT OUTPUT PICTURE NAME.
C
   44   CALL G3LINK(3,3,0,IDATA,RDATA)
C
        LNPICN= 0
        IF (LENGTH.LE.0) GO TO 1
        LNPICN= LENGTH
C
        DO 500 ICOPY= 1,LENGTH
          CALL G4BACO(IFUNIB(ICOPY+2),ICHAR)
          CALL G4PUTK(NAMEPO,ICOPY,NBITMC,NMCHI,ICHAR)
  500   CONTINUE
        GO TO 1
C
C          THIS SECTION DEALS WITH PICTURE INFORMATION (FUNCTION 62).
C          IF NO INFORMATION HAS BEEN SUPPLIED, NOTHING IS DONE.
C
   45   LNFOPO= 0
        IF (LENGTH.LE.0) GO TO 1
        LNFOPO= LENGTH
C
        DO 600 ICOPY= 1,LENGTH
          CALL G4BACO(IFUNIB(ICOPY+2),ICHAR)
          CALL G4PUTK(INFOPO,ICOPY,NBITMC,NMCHI,ICHAR)
  600   CONTINUE
        GO TO 1
C
C          THIS SECTION DEALS WITH TRANGRID END CODE (FUNCTION
C          63). A 'GREND' IS SENT TO CLOSE ALL OPEN GRIDFILES.
C
   46 CALL G3LINK(3,3,0,IDATA,RDATA)
      CALL G3LINK(1,2,0,IDATA,RDATA)
C
      IF (KIND.NE.2) WRITE(KMESGO,202)
  202 FORMAT(1X,'++ TRANGRID DECODING ENDED ++')
C
      RETURN
      END
