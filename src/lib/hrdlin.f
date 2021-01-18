      SUBROUTINE HRDLIN(ISET)
C
C          ------------------------------------------------
C          ROUTINE NO. (  53)   VERSION (A7.4)    11:FEB:85
C          ------------------------------------------------
C
C          THIS SELECTS HARDWARE OR SOFTWARE LINE TYPES.
C
C
      REAL    RDATA(1)
      INTEGER IDATA(1)
C
      COMMON /T0HRDL/ LHRDW0
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
C
      DATA RDATA /0.0/
C
C
      CALL G3INIT(2)
C
      ITRAC1= ISET
      IF (IPRINT.EQ.1) CALL G0MESG(46,5)
C
      LHRDW0= ISET
      IF (LHRDW0.NE.0) LHRDW0= 1
      IDATA(1)= LHRDW0
      CALL G3LINK(3,7,-1,IDATA,RDATA)
C
      RETURN
      END
