      SUBROUTINE G5JUSR(STRING,IOUTP,ISIZE,LENGTH,ICON)
C
C          ------------------------------------------------
C          ROUTINE NO. (5018)   VERSION (A7.3)    11:FEB:85
C          ------------------------------------------------
C
C          THIS CONVERTS LEFT-JUSTIFIED MACHINE CHARACTERS
C          (A1 FORMAT) TO RIGHT-JUSTIFIED GHOST CHARACTERS.
C
C
C          THE ARGUMENTS ARE AS FOLLOWS:
C
C          [STRING] CONTAINS THE INPUT MACHINE CHARACTER STRING;
C          [IOUTP]  RETURNS THE CONVERTED GHOST CHARACTER STRING;
C          <ISIZE>  GIVES THE SIZE OF THE ABOVE TWO ARRAYS;
C          <LENGTH> RETURNS THE LENGTH OF THE OUTPUT STRING;
C          <ICON>   GIVES THE ADDITIONAL OPERATIONS:
C                   = 0, NO ADDITIONAL OPERATIONS ARE PERFORMED,
C                   = 1, LOWER -> UPPER CASE CONVERSION IS DONE,
C                   = 2, MULTIPLE SPACES ARE REMOVED,
C                   = 3, BOTH OF THE ABOVE OPERATIONS ARE DONE.
C
C
      INTEGER   IOUTP(ISIZE)
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
        MNOW= ICHAR(STRING(ICOPY))
        CALL G4COCO(MNOW,KNOW)
        IF (EXSPAC.AND.KNOW.EQ.ISPACE.AND.KOLD.EQ.ISPACE) GO TO 100
        IF (UPCASE.AND.KNOW.GE.97) KNOW= KNOW-32
C
        LENGTH= LENGTH+1
        IOUTP(LENGTH)= KNOW
  100 CONTINUE
C
      RETURN
      END