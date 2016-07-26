      SUBROUTINE FILON
C
C          ------------------------------------------------
C          ROUTINE NO. ( 307)   VERSION (A7.4)    11:FEB:85
C          ------------------------------------------------
C
C          THIS ENABLES GRIDFILE OUTPUT.
C
C
      REAL    RDATA(1)
      INTEGER IDATA(1)
      LOGICAL GFOPEN,PPOPEN
C
      COMMON /T3OUTS/ GFOPEN,PPOPEN
C
      DATA RDATA /0.0/, IDATA /0/
C
C
      CALL G3INIT(2)
      CALL G3LINK(3,10,0,IDATA,RDATA)
      GFOPEN= .TRUE.
C
      RETURN
      END
