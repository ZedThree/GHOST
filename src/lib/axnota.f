      SUBROUTINE AXNOTA(NOTAT)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 191)   VERSION (A7.4)    11:FEB:85
C          ------------------------------------------------
C
C          THIS ENABLES AND DISABLES SUBSEQUENT AXES ANNOTATION.
C
C
C          <NOTAT>  SETS ANNOTATION CONTROL:
C                   IF ZERO, NO ANNOTATION IS DONE, OR
C                   IF NON-ZERO, ANNOTATION IS DONE.
C
C
      COMMON /T0NOTA/ NOTATA
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
C
C
      CALL G3INIT(2)
C
      ITRAC1= NOTAT
      IF (IPRINT.EQ.1) CALL G0MESG(69,5)
C
      NOTATA= 0
      IF (NOTAT.NE.0) NOTATA= 10
C
      RETURN
      END
