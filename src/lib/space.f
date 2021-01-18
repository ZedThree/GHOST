      SUBROUTINE SPACE(NSPACE)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 153)   VERSION (A7.3)    11:FEB:85
C          ------------------------------------------------
C
C          THIS DOES <NSPACE> SPACES ALONG THE CURRENT LINE
C          IN EITHER A POSITIVE OR A NEGATIVE DIRECTION.
C
C
      REAL    RDATA(1)
      INTEGER IDATA(2)
C
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
C
      DATA RDATA /0.0/
C
C
      ITRAC1= NSPACE
      IF (IPRINT.EQ.1) CALL G0MESG(64,5)
C
      IF (NSPACE.EQ.0) RETURN
C
      IDATA(1)= 1
      IDATA(2)= NSPACE
      IF (NSPACE.GT.0) GO TO 1
      IDATA(1)= 3
      IDATA(2)= -NSPACE
    1 CALL G3LINK(2,12,-2,IDATA,RDATA)
C
      RETURN
      END
