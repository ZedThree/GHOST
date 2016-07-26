      SUBROUTINE ISOSUR
C
C          ------------------------------------------------
C          ROUTINE NO. ( 138)   VERSION (A9.2)    07:MAY:92
C          ------------------------------------------------
C
C          THIS SETS AN ISOMETRIC PROJECTION
C          FOR THE ROUTINE <SURPLT>.
C
C
      COMMON /T0SANG/ TLTANG
      COMMON /T0SAZA/ AZIANG
      COMMON /T0TRAC/ IPRINT
C
C
      CALL G3INIT(2)
C
      IF (IPRINT.EQ.1) CALL G0MESG(154,0)
C
      TLTANG= 0.61548
      AZIANG= 0.785398
      RETURN
      END
