      SUBROUTINE BARTYP(KIND)
C
C          --------------------------------------------------
C          ROUTINE NO. (  89)    VERSION (A8.1)     10:DEC:85
C          --------------------------------------------------
C
C          THIS SELECTS HORIZONTAL OR VERTICAL BARS FOR BARCHARTS
C          AND HISTOGRAMS.
C
C
C          <KIND> = ZERO     FOR VERTICAL   BARS.
C          <KIND> = NON-ZERO FOR HORIZONTAL BARS.
C
C
      COMMON /T0BRTY/ IBRTYP
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
C
C
      CALL G3INIT(2)
C
      ITRAC1= KIND
      IF (IPRINT.EQ.1) CALL G0MESG(159,5)
C
      IBRTYP= KIND
      IF (IBRTYP.NE.0) IBRTYP= 1
C
      RETURN
      END
