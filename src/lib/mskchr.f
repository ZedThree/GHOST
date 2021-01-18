      SUBROUTINE MSKCHR(IENABL)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 183)   VERSION (A7.1)    11:FEB:85
C          ------------------------------------------------
C
C          THIS SETS WHETHER CHARACTERS ARE
C          SUBJECT TO THE MASK AREAS OR NOT.
C
C
      REAL    RDATA(1)
      INTEGER IDATA(1)
C
      COMMON /T0CVIS/ KWIND0,KMASK0
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
C
      DATA RDATA /0.0/
C
C
      CALL G3INIT(2)
C
      ITRAC1= IENABL
      IF (IPRINT.EQ.1) CALL G0MESG(140,5)
C
      KMASK0= IENABL
      IF (KMASK0.NE.0) KMASK0= 1
      IDATA(1)= KMASK0
      CALL G3LINK(2,14,-1,IDATA,RDATA)
      RETURN
      END
