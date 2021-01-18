      SUBROUTINE CTRFNT(KFONT)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 175)   VERSION (A8.5)    14:JUL:97
C          ------------------------------------------------
C
C          THIS SETS THE SUBSEQUENT CHARACTER FONT NO.
C
C
      REAL    RDATA(1)
      INTEGER IDATA(1)
C
      COMMON /T0CFON/ KFONT0
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
C
      DATA RDATA /0.0/
C
C
      CALL G3INIT(2)
      ITRAC1= KFONT
      IF (IPRINT.EQ.1) CALL G0MESG(111,5)
      IF (KFONT.LT.0.OR.KFONT.GT.255) RETURN
C
      KFONT0= KFONT
      IDATA(1)= KFONT0
      CALL G3LINK(2,2,-1,IDATA,RDATA)
C
      RETURN
      END
