      SUBROUTINE ENDBUF
C
C          ------------------------------------------------
C          ROUTINE NO. (  13)   VERSION (A7.3)    11:FEB:85
C          ------------------------------------------------
C
C
C          THIS RESTORES GRAPHICAL OUTPUT TO THE MAIN STREAM.
C
C
      REAL    RDATA(1)
      INTEGER IDATA(1)
C
      COMMON /T0BUFN/ KBUFR0
      COMMON /T0TRAC/ IPRINT
C
      DATA RDATA /0.0/, IDATA /0/
C
C
      IF (IPRINT.EQ.1) CALL G0MESG(115,0)
C
      KBUFR0= 0
      CALL G3LINK(4,2,-1,IDATA,RDATA)
C
      RETURN
      END
