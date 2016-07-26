      SUBROUTINE CONOTA(NOTAT)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 120)   VERSION (A8.2)    14:OCT:86
C          ------------------------------------------------
C
C          THIS ENABLES AND DISABLES SUBSEQUENT CONTOUR ANNOTATION.
C
C
C          <NOTAT>  SETS ANNOTATION CONTROL:
C                   =  0, TO DO NO ANNOTATION
C                   =  1, TO DO FULL ANNOTATION
C                   =  2, TO ANNOTATE INTERNAL CONTOURS ONLY
C                   =  4, TO ANNOTATE LEFT HAND EDGE ONLY
C                   =  8, TO ANNOTATE RIGHT HAND EDGE ONLY
C                   = 16, TO ANNOTATE TOP EDGE ONLY
C                   = 32, TO ANNOTATE BOTTOM EDGE ONLY.
C
C
      COMMON /T0NOTC/ NOTATC
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
C
C
      CALL G3INIT(2)
C
      ITRAC1= NOTAT
      IF (IPRINT.EQ.1) CALL G0MESG(70,5)
C
      NOTATC= NOTAT
      IF (NOTATC.LT.0.OR.NOTATC.EQ.1.OR.NOTATC.GT.62) NOTATC= 62
C
      RETURN
      END
