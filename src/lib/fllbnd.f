      SUBROUTINE FLLBND(IENABL)
C
C          ------------------------------------------------
C          ROUTINE NO. (  56)   VERSION (A8.1)    14:JUL:88
C          ------------------------------------------------
C
C          THIS SPECIFIES WHETHER THE BOUNDARY OF A FILLED
C          AREA IS TO BE DRAWN.
C
C
C          THE ARGUMENTS ARE AS FOLLOWS:
C
C          <IENABL>  IF SET TO ZERO, NO BOUNDARY IS DRAWN.
C
C
      COMMON /T0DBND/ IDRBND
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
C
C
      CALL G3INIT(2)
C
      ITRAC1= IENABL
      IF (IPRINT.EQ.1) CALL G0MESG(26,5)
C
      IDRBND= 0
      IF (IENABL.NE.0) IDRBND= 1
      RETURN
      END
