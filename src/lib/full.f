      SUBROUTINE FULL
C
C          ------------------------------------------------
C          ROUTINE NO. (  52)   VERSION (A7.4)    11:FEB:85
C          ------------------------------------------------
C
C          THIS RESETS LINE DRAWING TO CONTINUOUS FORM.
C          (IT IS EQUIVALENT TO <BROKEN> WITH NULL ARGUMENTS).
C
C
      REAL    RDATA(1)
      INTEGER IDATA(4)
C
      COMMON /T0LPAT/ MARKA0,MISSA0,MARKB0,MISSB0
      COMMON /T0TRAC/ IPRINT
C
      DATA RDATA /0.0/, IDATA /0,0,0,0/
C
C
      CALL G3INIT(2)
C
      IF (IPRINT.EQ.1) CALL G0MESG(23,0)
C
      MARKA0= 0
      MISSA0= 0
      MARKB0= 0
      MISSB0= 0
C
      CALL G3LINK(3,6,-4,IDATA,RDATA)
C
      RETURN
      END
