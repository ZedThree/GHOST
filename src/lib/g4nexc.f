      SUBROUTINE G4NEXC(IARRAY,ISTRT,ISTOP,ISIZE,ITYPE,IPOSN)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 276)   VERSION (A7.4)    03:JAN:86
C          ------------------------------------------------
C
C          THIS FINDS THE POSITION <IPOSN> OF THE FIRST CHARACTER
C          OF THE TYPE GIVEN BY <ITYPE> BETWEEN POSITIONS <ISTRT>
C          AND <ISTOP> IN THE (UNPACKED) ARRAY [IARRAY] OF LENGTH
C          <ISIZE>. IF NO OCCURRENCE IS FOUND, <IPOSN> IS SET TO 0.
C
C          <ITYPE> SETS THE FOLLOWING TYPES:
C
C                  =  1, THE FIRST     SEPARATOR CHARACTER.
C                  = -1, THE FIRST NON-SEPARATOR CHARACTER.
C                  =  2, THE FIRST     NUMERIC CHARACTER.
C                  = -2, THE FIRST NON-NUMERIC CHARACTER.
C                  =  3, THE FIRST     ALPHABETIC CHARACTER.
C                  = -3, THE FIRST NON-ALPHABETIC CHARACTER.
C                  =  4, THE FIRST     SPACE.
C                  = -4, THE FIRST NON-SPACE.
C
C
      INTEGER IARRAY(ISIZE)
C
C
      IPOSN= 0
      IF (ISTRT.GT.ISIZE) RETURN
      IF (ISTOP.LE.0)     RETURN
      IF (ISTRT.GT.ISTOP) RETURN
C
C          <KTYPE> IS SET ACCORDING TO THE CHARACTER TYPE:
C
C                  = 1, IT IS A SEPARATOR,
C                  = 2, IT IS A NUMBER, OR
C                  = 3, IT IS ALPHABETIC.
C
      LIM1= ISTRT
      IF (ISTRT.LT.1) LIM1= 1
C
      LIM2= ISTOP
      IF (ISTOP.GT.ISIZE) LIM2= ISIZE
C
      DO 100 LOOK= LIM1,LIM2
        ICHAR= IARRAY(LOOK)
        KTYPE= 1
        IF (ICHAR.GE. 48) KTYPE= 2
        IF (ICHAR.GE. 58) KTYPE= 1
        IF (ICHAR.GE. 65) KTYPE= 3
        IF (ICHAR.GE. 91) KTYPE= 1
        IF (ICHAR.GE. 97) KTYPE= 3
        IF (ICHAR.GE.123) KTYPE= 1
        IF (ICHAR.GT.128) KTYPE= 3
        IF (ITYPE.LT.0)                  GO TO 1
        IF (KTYPE.EQ.ITYPE)              GO TO 2
        IF (ITYPE.EQ. 4.AND.ICHAR.EQ.32) GO TO 2
        GO TO 100
C
    1   IF (KTYPE.NE.IABS(ITYPE))        GO TO 2
        IF (ITYPE.EQ.-4.AND.ICHAR.NE.32) GO TO 2
  100 CONTINUE
      RETURN
C
    2 IPOSN= LOOK
      RETURN
      END
