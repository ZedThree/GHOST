      SUBROUTINE PAPER(ISWICH)
C
C          ------------------------------------------------
C          ROUTINE NO. (   2)   VERSION (A7.4)    11:FEB:85
C          ------------------------------------------------
C
C          THIS SWITCHES CHANNEL-1 ON AND OFF.
C
C
C          <ISWICH> IS ZERO FOR OFF AND NON-ZERO FOR ON.
C
C
      REAL    RDATA(1)
      INTEGER IDATA(1)
C
      COMMON /T0DEVS/ KCHAN0(5),IRESL0
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
C
      DATA RDATA /0.0/, IDATA /1/
C
C
      CALL G3INIT(2)
C
      ITRAC1= ISWICH
      IF (IPRINT.EQ.1) CALL G0MESG(1,5)
C
      IF (ISWICH.EQ.0) GO TO 1
      KCHAN0(1)= 1
      CALL G3LINK(3,1,-1,IDATA,RDATA)
      RETURN
C
    1 KCHAN0(1)= 0
      CALL G3LINK(3,2,-1,IDATA,RDATA)
      RETURN
      END
