      PROGRAM BUILD
C
C Program to build Hershey direct serial font files for Ghost80.
C Inputs:-
C 1.    COMFIN file, containing a combined font index.
C       Records (one per Hershey character) are of the form:-
C       <I5> <1X> <I3> <1X> <A2> <1X> <A1> <1X> <A2>
C       Fields are:-
C        Character index in the HERSHY file (qv)
C        ASCII decimal character code, which is the Ghost
C          character no.-1
C        ASCII hex code.
C        Printable equivalent.
C        Font mnemonic
C
C 2.    HERSHY file, containing the character vectors.
C       Records (one or more per Hershey character definition) are
C       of the form:-
C       <I5> <3X> <9(2(F3.0,1X))>
C       Fields are of the form:-
C        Hershey character index, only present on the first record.
C        Nine x,y pairs. If x=-64 then y is rubbish and the following
C          pair (only) represents a penup movement. If y=-64, then
C          the character definition is finished.
C          The first x,y pair in each definition is ignored.
C
C
C Outputs:-
C
C          The program creates 15 direct serial files, each with 256
C          Ghost80 character definitions.
C          The file format is described in Ghost Technical Committee
C          GTC/84/P/18, by Anthony Matthew, University Leicester, 1984.
C          The files are named GHOST80FONT11 TO GHOST80FONT25.
C          These correspond to Ghost font numbers 11 to 25.
C          The first 16  records of the file contain the internal
C          index for the file. This consists of 256 entries, each
C          defining the start record within the file of the Ghost80
C          character definition, the length of the definition in terms
C          of the number of coordinate pairs, and a real number which
C          is the width of the character, as a fraction of the nominal
C          width of 6 Ghost80 character units.
C          There is unlikely to be any implementation of Fortran which
C          requires more space in a direct serial file record for
C          16 reals plus 32 integers than for 60 reals, which is the
C          size of the main record.
C          'Main' records each contain a maximum of 30 real coordinate pairs,
C          which define polylines on the usual Ghost80 6 by 12 grid.
C          An x-coordinate of <-100.0 signifies an interruption in the
C          polyline.
C
C
C          INDLEN and WIDCHR are used to build up the indexes to the
C          output files. The last subscript of the arrays must be
C          declared as the value of MAXFNT-MINFNT+1.
C
      REAL       WIDCHR(0:255,15), XC(200), YC(200)
      INTEGER    INDLEN(2,0:255,15),INDREC(15)
      LOGICAL    DONE
      CHARACTER  FILNAM*13, PRNTBL*1, FMNEM*2, HERLIN*80
C
C          <IRECL> IS THE LENGTH OF THE DATA RECORD. THE UNITS
C          WHICH THE LENGTH IS SPECIFIED ARE MACHINE DEPENDANT.
C
C          THE UNITS ARE '4-CHARACTER WORDS' FOR THE FOLLOWING COMPUTERS:
C          VAX, MISTRAL, SILICON GRAPHICS
C          (SET IRECL TO 60).
C
C          THE UNITS ARE '2-CHARACTER WORDS' FOR THE FOLLOWING COMPUTERS:
C          PRIME (F77 AND FTN77 COMPILERS)
C          (SET IRECL TO 120).
C
C          THE UNITS ARE 'CHARACTERS' FOR THE FOLLOWING COMPUTERS:
C          APOLLO, GEC, HP, IBMPC, IBM WS, SUN, WHITECHAPEL
C          (SET IRECL TO 240).
C
C          THE UNITS ARE 'CHARACTERS' FOR THE FOLLOWING COMPUTERS:
C          CRAY
C          (SET IRECL TO 480).
C
      PARAMETER (MINFNT=11, MAXFNT=25, IRECL=GHOST_RECL_UNIT*60)
C
      DATA INDHH /-1/, XMAX, YMAX /2*0.0/, XMIN, YMIN /2*100.0/
      DATA IHERUN /78/, ICOMUN /79/, IFNTST /80/
C
C
      DO 100 K= 1,15
        DO 100 J= 0,255
          DO 100 I= 1,2
            INDLEN(I,J,K)= 0
  100 CONTINUE
C
      DO 200 J= 1,15
        DO 200 I= 0,255
          WIDCHR(I,J)= 1.0
  200 CONTINUE
C
      OPEN(IHERUN,FILE='HERSHY.DAT',STATUS='OLD')
      OPEN(ICOMUN,FILE='COMFIN.DAT',STATUS='OLD')
      IUNIT= IFNTST
C
      DO 300 NOFONT= MINFNT,MAXFNT
        INDREC(NOFONT-MINFNT+1)= 16
        WRITE(FILNAM,'(11HGHOST80FONT, I2)')NOFONT
        OPEN(IUNIT,FILE=FILNAM(:13),
     &       STATUS='NEW',ACCESS='DIRECT',RECL=IRECL)
        IUNIT= IUNIT+1
  300 CONTINUE
C
C          MAIN LOOP
C
    1 READ(ICOMUN,'( I5,1X,  I3,1X,2X,1X, A1,1X,  A2   )',END=4)
     &     INDCH, IASCOD, PRNTBL, FMNEM
C
C          If INDCH=0 (a space), then ignore it.
C
      IF (INDCH.EQ.0) GO TO 1
C
      IND= INDEX('SR DR CR TR CI TI SS CS SG CC CG GE GG GI EX',FMNEM)
      INDFNT= IND/3
      NOFILE= INDFNT+IFNTST
C
C          If for a new Hershey character, then go read and interpret
C          the Hershey definition in HERSHY file. Note that COMFIN
C          is sorted in ascending hershey key order, so no need to
C          access HERSHEY other than serially.
C
      IF (INDCH.NE.INDHH) THEN
    2   READ(IHERUN,'(A)',END=5)HERLIN
        READ(HERLIN,'(I5)')INDHH
        IF (INDHH.LT.INDCH) GO TO 2
C
        DONE= .FALSE.
        NF= 1
        NC= 0
        CXMIN= 64.0
        CXMAX= -CXMIN
    3   IF (.NOT.DONE) THEN
          IF (NF.GT.9) THEN
            READ(IHERUN,'(A)',END=5)HERLIN
            NF= 1
          END IF
          READ(HERLIN(NF*8+1:(NF+1)*8),'(2(F3.0,1X))')X,Y
          IF (NC.EQ.0) THEN
            NC= 0
          ELSE IF (Y.LT.-63.0) THEN
            NC= NC-2
            DONE= .TRUE.
          ELSE IF (X.LT.-63.0) THEN
            XC(NC)= -100.1
            YC(NC)= 0.0
          ELSE
            IF (X.GT.XMAX) THEN
              XMAX= X
            ELSE IF (X.LT.XMIN) THEN
              XMIN= X
            END IF
            IF (Y.GT.YMAX) THEN
              YMAX= Y
            ELSE IF (Y.LT.YMIN) THEN
                   YMIN= Y
            END IF
            IF (X.GT.CXMAX)CXMAX= X
            IF (X.LT.CXMIN)CXMIN= X
C
            XC(NC)= X
C
C          Map hershey y coordinates such that 9 -> -12 corresponds to
C          GHOST character box of 0 -> 7...
C
            YC(NC)= 3.0-Y/3.0
          END IF
C
          NC=NC+1
          NF=NF+1
          GO TO 3
        END IF
C
C          Store a width for the character as a proportion of the
C          'standard' width of 6 units by calculating the ghost width,
C          then adding two units.
C
        XHRNGE= CXMAX-CXMIN
C
        DO 400 I= 1,NC
          IF (XC(I).GT.-100.0) XC(I)= 3.0+(XC(I)-(CXMIN+CXMAX)*0.5)/3.0
  400   CONTINUE
C
        WIDTH= (XHRNGE/3.0+2.0)/6.0
C
C Adjust width for letters on italic and script fonts.
C
        IF (INDFNT.GE.4.AND.INDFNT.LE.7.AND.
     &      IASCOD.GE.65.AND.IASCOD.LE.122) WIDTH= WIDTH-0.18333
        IF ((INDFNT.EQ.6.OR.INDFNT.EQ.7).AND.
     &      IASCOD.GE.97.AND.IASCOD.LE.122) WIDTH= WIDTH-0.15
C
      END IF
C
C          Output the character definition to the Ghost80 direct serial
C          file. Output next higher multiple of 30 coordinate pairs.
C          The surplus does no harm!
C
      NRECS= INT((NC-1)/30)+1
      INDX= NOFILE-IFNTST+1
C
      DO 500 I= 1,NRECS
        WRITE(NOFILE,REC=INDREC(INDX)+I,ERR=901)
     &       (XC(J),YC(J),J=(I-1)*30+1,I*30)
  500 CONTINUE
C
      INDLEN(1,IASCOD,INDX)= INDREC(INDX)+1
      INDLEN(2,IASCOD,INDX)= NC
      WIDCHR(IASCOD,INDX)= WIDTH
      INDREC(INDX)= INDREC(INDX)+NRECS
      GO TO 1
C
C          Output index.
C
    4 IUNIT= IFNTST
C
      DO 600 I= MINFNT,MAXFNT
        INDX= 0
        INDX1= I-MINFNT+1
C
        DO 700 NOREC= 1,16
          WRITE(IUNIT,REC=NOREC)
     &         ((INDLEN(K,J,INDX1),K=1,2),WIDCHR(J,INDX1),
     &    J= INDX,INDX+15)
          INDX= INDX+16
  700   CONTINUE
C
        WRITE(*,'(A,I2,A,I4,A)') 'Closed GHOST80FONT',I,' with ',
     &        INDREC(INDX1),' records.'
        CLOSE(IUNIT)
        IUNIT= IUNIT+1
  600 CONTINUE
C
      CLOSE(IHERUN)
      CLOSE(ICOMUN)
      WRITE(*,*) 'Raw hershey data envelope - ',XMIN,XMAX,YMIN,YMAX
      STOP
C
    5 WRITE(*,*) 'Premature end of HERSHY data file...'
      WRITE(*,*) 'Searching for hershey char ',INDCH
      WRITE(*,*) 'Output files incomplete.'
      GO TO 4
C
  901 WRITE(*,*) 'ERROR in write statement '
      WRITE(*,*) 'I,J,INDX,XC,YC'
      WRITE(*,*) I,J,INDX,XC(J),YC(J)
      STOP
C
      END
