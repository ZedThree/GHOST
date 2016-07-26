      SUBROUTINE SURIND(IENABL)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 136)   VERSION (A7.1)    11:FEB:85
C          ------------------------------------------------
C
C          THIS SPECIFIES WHETHER AN AXIS DIRECTION INDICATOR
C          IS TO BE DRAWN BY THE ROUTINE <SURPLT>.
C
C
C          THE ARGUMENTS ARE AS FOLLOWS:
C
C          <IENABL>  IF SET TO ZERO, NO AXIS DIRECTION
C                    INDICATOR IS PLOTTED.
C
C
      COMMON /T0SIND/ ISURIN
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
C
C
      CALL G3INIT(2)
C
      ITRAC1= IENABL
      IF (IPRINT.EQ.1) CALL G0MESG(151,5)
C
      ISURIN= 0
      IF (IENABL.NE.0) ISURIN= 1
      RETURN
      END
