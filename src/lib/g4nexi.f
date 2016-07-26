      SUBROUTINE G4NEXI(IARRAY,ISTRT,ISTOP,ISIZE,IVALUE,LENN,IPOSN)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 278)   VERSION (A7.4)    03:JAN:86
C          ------------------------------------------------
C
C          THIS DECODES THE FIRST CONTIGUOUS SEQUENCE OF DIGITS
C          IN A GIVEN CHARACTER STRING INTO AN INTEGER. THE
C          FIRST POSITION AFTER THE DIGIT SEQUENCE IS ALSO FOUND.
C          NEGATIVE NUMBERS ARE REDUCED IN VALUE BY 1 TO
C          DIFFERENTIATE BETWEEN +0 AND -0.
C
C
C          THE INPUT ARGUMENTS ARE AS FOLLOWS:
C
C          [IARRAY] HOLDS THE CHARACTER STRING (GHOST CHARS.),
C          <ISTRT>  IS THE STARTING POINT OF THE STRING,
C          <ISTOP>  IS THE STOPPING POINT OF THE STRING,
C          <ISIZE>  IS THE TOTAL SIZE OF THE ARRAY.
C
C
C          AND THE OUTPUT ARGUMENTS ARE AS FOLLOWS:
C
C          <IVALUE> IS THE VALUE FOUND FROM THE STRING,
C          <LENN>   IS THE NUMBER OF CONSECUTIVE DIGITS FOUND,
C          <IPOSN>  IS THE NEXT POSITION AFTER THE DIGIT SEQUENCE
C                   (AND IS SET TO ZERO IF NO CHARACTERS REMAIN).
C
C
      INTEGER IARRAY(ISIZE)
      LOGICAL MINUS
C
      DATA KSPACE /32/, KPLUS /43/, KMINUS /45/, KPOINT /46/
C
C
      IVALUE= 0
      IPOSN= 0
      LENN= 0
      IF (ISTOP.LT.ISTRT) RETURN
C
      CALL G4NEXC(IARRAY,ISTRT,ISTOP,ISIZE,+2,IPOS1)
      IF (IPOS1.GT.0) GO TO 1
C
      IPOS1= ISTRT
      IPOS2= ISTOP
      GO TO 2
C
    1 CALL G4NEXC(IARRAY,IPOS1,ISTOP,ISIZE,-2,IPOS2)
      IF (IPOS2.LE.0) IPOS2= ISTOP+1
C
C          LOOP-100 DECODES THE DIGITS INTO A NUMBER;
C          NOTE THAT NO MORE THAN 9 DIGITS ARE USED.
C
      IPOSN= IPOS2
      IF (IPOSN.GT.ISIZE) IPOSN= 0
C
      LENN= IPOS2-IPOS1
      IF (LENN.GT.9) LENN= 9
C
      IPOS2= IPOS1+LENN-1
C
      DO 100 LOOK= IPOS1,IPOS2
        IDIGIT= IARRAY(LOOK)-48
        IVALUE= IVALUE*10+IDIGIT
  100 CONTINUE
C
C          THIS SECTION DETERMINES THE SIGN, IF REQUIRED.
C          SPACES AND PAIRS OF MINUS SIGNS ARE IGNORED.
C
      IF (IPOS1.LE.ISTRT) RETURN
C
      IPOS2= IPOS1-1
      CALL G4NEXC(IARRAY,ISTRT,IPOS2,ISIZE,-4,IPOS1)
      IF (IPOS1.LT.ISTRT) RETURN
C
    2 MINUS= .FALSE.
C
      DO 200 LOOK= IPOS1,IPOS2
        ICHAR= IARRAY(LOOK)
        IF (ICHAR.EQ.KMINUS) GO TO 3
        IF (ICHAR.EQ.KPLUS)  GO TO 200
        IF (ICHAR.EQ.KSPACE) GO TO 200
        IF (ICHAR.EQ.KPOINT) GO TO 4
C
        MINUS= .TRUE.
    3   MINUS= .NOT.MINUS
  200 CONTINUE
C
    4 IF (MINUS) IVALUE= -IVALUE-1
C
      RETURN
      END
