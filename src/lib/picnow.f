      SUBROUTINE PICNOW
C
C          ------------------------------------------------
C          ROUTINE NO. (  11)   VERSION (A7.3)    11:FEB:85
C          ------------------------------------------------
C
C          THIS CAUSES IMMEDIATE OUTPUT OF ALL GRAPHIC BUFFERS.
C
C
      REAL    RDATA(1)
      INTEGER IDATA(1)
C
      COMMON /T0TRAC/ IPRINT
C
      DATA RDATA /0.0/, IDATA /0/
C
C
      IF (IPRINT.EQ.1) CALL G0MESG(119,0)
C
      CALL G3LINK(3,10,0,IDATA,RDATA)
      RETURN
      END
