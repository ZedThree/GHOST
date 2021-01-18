      SUBROUTINE G5JUSL(INPUT,STRING,ISIZE,LENGTH,ICON)
C
C          ------------------------------------------------
C          ROUTINE NO. (5017)   VERSION (A7.3)    11:FEB:85
C          ------------------------------------------------
C
C          THIS CONVERTS RIGHT-JUSTIFIED GHOST CHARACTERS
C          TO LEFT-JUSTIFIED MACHINE CHARACTERS (A1 FORMAT).
C
C
C          THE ARGUMENTS ARE AS FOLLOWS:
C
C          [INPUT]  CONTAINS THE INPUT GHOST CHARACTER STRING;
C          [STRING] RETURNS THE CONVERTED MACHINE CHARACTER STRING;
C          <ISIZE>  GIVES THE SIZE OF THE ABOVE TWO ARRAYS;
C          <LENGTH> RETURNS THE LENGTH OF THE OUTPUT STRING;
C          <ICON>   GIVES THE ADDITIONAL OPERATIONS:
C                   = 0, NO ADDITIONAL OPERATIONS ARE PERFORMED,
C                   = 1, LOWER -> UPPER CASE CONVERSION IS DONE,
C                   = 2, MULTIPLE SPACES ARE REMOVED,
C                   = 3, BOTH OF THE ABOVE OPERATIONS ARE DONE.
C
C
      INTEGER   INPUT(ISIZE)
      LOGICAL   UPCASE,EXSPAC
      CHARACTER STRING(ISIZE)
C
      DATA ISPACE /32/
C
C
      UPCASE= (MOD(ICON,2).EQ.1)
      EXSPAC= (ICON.GE.2)
      KNOW= -1
      LENGTH= 0
C
      DO 100 ICOPY= 1,ISIZE
        KOLD= KNOW
        KNOW= MOD(INPUT(ICOPY),128)
        IF (EXSPAC.AND.KNOW.EQ.ISPACE.AND.KOLD.EQ.ISPACE) GO TO 100
        IF (UPCASE.AND.KNOW.GE.97) KNOW= KNOW-32
C
        CALL G4BACO(KNOW,MNOW)
        LENGTH= LENGTH+1
        STRING(LENGTH)= CHAR(MNOW)
  100 CONTINUE
C
      RETURN
      END
