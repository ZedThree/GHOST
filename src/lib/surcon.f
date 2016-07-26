      SUBROUTINE SURCON(IENABL)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 342)   VERSION (A9.1)    05:MAY:92
C          ------------------------------------------------
C
C          THIS SPECIFIES WHETHER CONTOUR LINES ARE
C          TO BE DRAWN ON A SURFACE.
C
C
      COMMON /T0SCON/ JCONTR
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
C
C
      CALL G3INIT(2)
C
      ITRAC1= IENABL
      IF (IPRINT.EQ.1) CALL G0MESG(190,5)
C
      JCONTR= IENABL
      IF (IENABL.NE.0) JCONTR= 1
C
      RETURN
      END
