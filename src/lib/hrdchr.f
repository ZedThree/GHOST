      SUBROUTINE HRDCHR(ISET)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 174)   VERSION (A7.4)    11:FEB:85
C          ------------------------------------------------
C
C          THIS SELECTS HARDWARE OR SOFTWARE CHAR. TYPES.
C
C
      REAL    RDATA(1)
      INTEGER IDATA(1)
C
      COMMON /T0HRDC/ KHRDW0
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
C
      DATA RDATA /0.0/
C
C
      CALL G3INIT(2)
C
      ITRAC1= ISET
      IF (IPRINT.EQ.1) CALL G0MESG(47,5)
C
      KHRDW0= ISET
      IF (KHRDW0.NE.0) KHRDW0= 1
      IDATA(1)= KHRDW0
      CALL G3LINK(2,1,-1,IDATA,RDATA)
C
      RETURN
      END
