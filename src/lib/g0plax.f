      SUBROUTINE G0PLAX(LINE)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 233)   VERSION (A8.7)    11:SEP:97
C          ------------------------------------------------
C
C          THIS DRAWS TICK MARKS AND (OPTIONALLY) AN AXIS LINE,
C          WITH LINEAR MARKINGS ALONG THE X-DIRECTION.
C
C          <LINE>   CONTROLS WHETHER THE AXIS LINE IS DRAWN:
C                   IF ZERO, ONLY TICK MARKS ARE DRAWN,
C                   OTHERWISE, THE AXIS LINE IS ALSO DONE.
C
C
C          THE FOLLOWING ARGUMENTS ARE SUPPLIED THROUGH COMMON:
C
C          <NOTATA> IF ZERO, NO ANNOTATION IS REQUIRED,
C                   IF NON-ZERO, ANNOTATION IS DONE.
C          <AXPOSX> THE POSITION OF THE X-AXIS ALONG Y.
C          <DIVLX>  IS THE X-AXIS SUB-INTERVAL SIZE.
C          <NSKIPX> IS THE NO. OF SUB-INTERVALS PER MAJOR INTERVAL IN X.
C          <NTIKLX> IS THE MARKING START-POINT FOR THE X-AXIS.
C          <NTIKHX> IS THE MARKING END-  POINT FOR THE X-AXIS.
C          <NDECSX> IS THE X-AXIS ANNOTATION BASIS-EXPONENT.
C          <NCHRSX> IS THE NO. OF CHARS. IN X-AXIS ANNOTATION.
C          <NAFTPX> IS THE NO. OF CHARS. AFTER THE DEC. PT. IN X.
C          <KANNX>  GIVES THE X-AXIS ANNOTATION TYPE, AS FOLLOWS:
C                   = 1, IT IS INTEGER
C                   = 2, IT IS REAL,
C                   = 3, IT IS INTEGER WITH MULT. FACTOR.
C                   = 4, IT IS REAL    WITH MULT. FACTOR.
C          <KAXIS>  INDICATES WHETHER ANNOTATION MAY BE SUPPRESSED:
C                   > 0, NO, OR
C                   < 0, YES, IF IT INTERFERES WITH THE OTHER AXIS.
C          <TKEN1A> AND
C          <TKEN1B> ARE THE END-POINTS OF THE 5/1000TH.-SIZE TICK MARK.
C          <TKEN2A> AND
C          <TKEN2B> ARE THE END-POINTS OF THE 8/1000TH.-SIZE TICK MARK.
C
C
      REAL    RDATA(1)
      INTEGER IDECFC(3)
C
      COMMON /T0AARG/ KAXIS
      COMMON /T0ADIX/ DIVLX,NTIKLX,NTIKHX
      COMMON /T0ANOD/ KDIRX,KDIRY
      COMMON /T0ANOX/ KANNX,NCHRSX,NAFTPX
      COMMON /T0APOS/ AXPOSX,AXPOSY
      COMMON /T0ASKX/ NSKIPX,NDECSX
      COMMON /T0ATIK/ TKEN1A,TKEN1B,TKEN2A,TKEN2B
      COMMON /T0NOTA/ NOTATA
      COMMON /T0WNDO/ X1WND0,X2WND0,Y1WND0,Y2WND0
      COMMON /T3LIMS/ IMAXI,RMAXI,RMINI
C
      DATA RDATA /0.0/, IDECFC /120,49,48/
C
C
C          THE AXIS LINE IS DRAWN HERE, IF REQUIRED.
C
      IF (LINE.EQ.0) GO TO 1
C
      CALL POSITN(X1WND0,AXPOSX)
      CALL   JOIN(X2WND0,AXPOSX)
C
C          THE NO. OF TICK MARKS IS CALCULATED, AND IF NONE EXIST,
C          NO MORE NEED BE DONE. OTHERWISE, THE CURRENT FONT NO.
C          IS SAVED, THE SCALING FACTOR IS CALCULATED, AND THE
C          INITIAL SUB-INTERVAL COUNT IS SET UP. LOOP-100 THEN
C          DRAWS EACH TICK MARK (OF THE APPROPRIATE SIZE) IN TURN,
C          ALSO ANNOTATING THE MAJOR INTERVALS AS REQUIRED.
C
    1 NTICKS= NTIKHX-NTIKLX+1
      IF (NTICKS.LE.0) RETURN
      IF (NOTATA.NE.0) FACTOR= 10.0**(-NDECSX)
C
      IMISS= NTIKHX/NSKIPX
      IMISS= IMISS*NSKIPX-NTIKHX-1
      IF (NTIKHX.GE.0) IMISS= IMISS+NSKIPX
      IF (IMISS.LT.0) IMISS= NSKIPX
C
      DO 100 ITICK= 1,NTICKS
        XPOS= DIVLX*(NTIKHX-ITICK+1)
        TKENDA= TKEN1A
        TKENDB= TKEN1B
        IMISS= IMISS+1
        IF (IMISS.LT.NSKIPX) GO TO 2
C
        IMISS= 0
        TKENDA= TKEN2A
        TKENDB= TKEN2B
C
C          THE APPROPRIATE-SIZE TICK MARK IS DRAWN. IF ANNOTATION
C          IS NOT REQUIRED, OR IF THIS POSITION IS NOT ON A MAJOR
C          INTERVAL, LOOP-100 CONTINUES WITH THE NEXT TICK MARK.
C
    2   CALL POSITN(XPOS,TKENDA)
        CALL   JOIN(XPOS,TKENDB)
        IF (NOTATA.EQ.0) GO TO 100
        IF (IMISS.NE.0)  GO TO 100
C
C          THIS SECTION SUPPRESSES ANNOTATION (IF REQUIRED)
C          WHEN THE X-AXIS IS WITHIN THE WINDOW AREA AND THE
C          CURRENT TICK POSITION IS TOO CLOSE TO THE Y-AXIS.
C
        IF (KAXIS.GT.0) GO TO 3
        IF (ABS(AXPOSX-Y1WND0).LT.RMINI.AND.KDIRY.LE.0) GO TO 3
        IF (ABS(AXPOSX-Y2WND0).LT.RMINI.AND.KDIRY.GE.1) GO TO 3
C
        XDIFF= ABS(XPOS-AXPOSY)
        IF (XDIFF.GT.0.25*DIVLX) GO TO 3
        IF (XDIFF.LT.0.05*ABS(X2WND0-X1WND0)) GO TO 100
C
C          WHEN ANNOTATION IS TO BE DONE, THE POSITION IS SET,
C          THE APPROPRIATE FORMAT SELECTED, AND THE VALUE PRINTED.
C
    3   CALL POSITN(XPOS,AXPOSX)
        IF (KDIRX.LE.0) CALL LINEFD(2)
        IF (KDIRX.GE.1) CALL HLINFD(-3)
C
        CALL HSPACE(-NCHRSX+1)
        VALUE= XPOS
        IF (KANNX.GT.2) VALUE= FACTOR*VALUE
        IF (KANNX.EQ.2.OR.KANNX.EQ.4) GO TO 4
C
        IVALUE= VALUE+SIGN(0.5,VALUE)
        CALL TYPENI(IVALUE)
        GO TO 100
C
    4   CALL TYPENF(VALUE,NAFTPX)
  100 CONTINUE
C
C          IF THE FORMAT REQUIRES A MULTIPLYING FACTOR,
C          ITS POSITION IS SET AND ITS VALUE PRINTED.
C
      IF (NOTATA.EQ.0) RETURN
      IF (KANNX.LT.3) RETURN
      IF (SIGN(1.0,(X1WND0-AXPOSY))*SIGN(1.0,(X2WND0-AXPOSY)).GE.0.0)
     &    GO TO 5
C
      START= AXPOSY
      WIDE= X2WND0
      IF (ABS(X2WND0).LT.ABS(0.9*X1WND0)) WIDE= X1WND0
      GO TO 6
C
    5 START= X1WND0
      WIDE= X2WND0-X1WND0
    6 MULTPT= (0.6667*WIDE+START)/DIVLX
      XPOS= MULTPT*DIVLX
      CALL POSITN(XPOS,AXPOSX)
      IF (KDIRX.LE.0) CALL HLINFD(7)
      IF (KDIRX.GE.1) CALL LINEFD(-3)
C
      CALL G3LINK(2,11,-3,IDECFC,RDATA)
      CALL SUPFIX
      IF (NDECSX.GE.0) CALL SPACE(-1)
C
      CALL TYPENI(NDECSX)
      CALL NORMAL
      RETURN
      END