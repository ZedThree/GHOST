      SUBROUTINE UNDLIN(NLINES)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 147)   VERSION (A7.4)    11:FEB:85
C          ------------------------------------------------
C
C          THIS SETS FOR CHARACTER UNDERLINING.
C
C
C          <NLINES> GIVES THE NO. OF UNDERLINES.
C
C
      REAL    RDATA(1)
      INTEGER IDATA(1)
C
      COMMON /T0CATT/ IUNDL0,ITAL0
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
C
      DATA RDATA /0.0/
C
C
      CALL G3INIT(2)
C
      ITRAC1= NLINES
      IF (IPRINT.EQ.1) CALL G0MESG(58,5)
C
      IUNDL0= NLINES
      IF (IUNDL0.LT.0) IUNDL0= 0
      IF (IUNDL0.GT.2) IUNDL0= 2
      IDATA(1)= IUNDL0
      CALL G3LINK(2,7,-1,IDATA,RDATA)
C
      RETURN
      END
