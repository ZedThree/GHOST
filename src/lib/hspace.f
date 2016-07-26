      SUBROUTINE HSPACE(NHALFS)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 154)   VERSION (A7.3)    11:FEB:85
C          ------------------------------------------------
C
C          THIS DOES <NHALFS> HALF-SPACES ALONG THE CURRENT LINE
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
      ITRAC1= NHALFS
      IF (IPRINT.EQ.1) CALL G0MESG(65,5)
C
      IF (NHALFS.EQ.0) RETURN
C
      IDATA(1)= 2
      IDATA(2)= NHALFS
      IF (NHALFS.GT.0) GO TO 1
C
      IDATA(1)= 4
      IDATA(2)= -NHALFS
    1 CALL G3LINK(2,12,-2,IDATA,RDATA)
C
      RETURN
      END
