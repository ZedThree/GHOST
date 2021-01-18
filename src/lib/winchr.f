      SUBROUTINE WINCHR(IENABL)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 178)   VERSION (A7.3)    11:FEB:85
C          ------------------------------------------------
C
C          THIS SETS WHETHER CHARACTERS ARE
C          SUBJECT TO THE VECTOR WINDOW OR NOT.
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
      IF (IPRINT.EQ.1) CALL G0MESG(127,5)
C
      KWIND0= IENABL
      IF (KWIND0.NE.0) KWIND0= 1
      IDATA(1)= KWIND0
      CALL G3LINK(2,13,-1,IDATA,RDATA)
      RETURN
      END
