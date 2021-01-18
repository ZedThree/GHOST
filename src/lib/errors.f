      SUBROUTINE ERRORS(ITRACE)
C
C          ------------------------------------------------
C          ROUTINE NO. (  17)   VERSION (A7.4)    11:FEB:85
C          ------------------------------------------------
C
C          THIS SWITCHES ERROR MESSAGE PRINTING ON AND OFF.
C
C
      REAL    RDATA(1)
      INTEGER IDATA(1)
      LOGICAL ERRON
C
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
      COMMON /T3ERRS/ ERRON,NUMERR
C
      DATA RDATA /0.0/, IDATA /0/
C
C
      CALL G3INIT(2)
C
      ITRAC1= ITRACE
      IF (IPRINT.EQ.1) CALL G0MESG(123,5)
C
      CALL G3LINK(3,10,0,IDATA,RDATA)
C
      ERRON= .FALSE.
      IF (ITRACE.NE.0) ERRON= .TRUE.
      NUMERR= 0
C
      RETURN
      END
