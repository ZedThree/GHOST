      SUBROUTINE CTRORI(ANGLE)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 144)   VERSION (A7.4)    11:FEB:85
C          ------------------------------------------------
C
C          THIS SETS THE CHARACTER STRING ANGLE.
C
C
C          <ANGLE>  IS THE ANGLE FROM THE HORIZONTAL IN
C                   UNITS OF THE CURRENTLY-SET ANGLE TYPE.
C
C
      REAL    RDATA(1)
      INTEGER IDATA(1)
C
      COMMON /T0ACON/ ANGCON
      COMMON /T0CANG/ STANG0,CRANG0
      COMMON /T0CSLO/ SLOPE,MRKSLP
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAR/ RTRAC1,RTRAC2,RTRAC3,RTRAC4
      COMMON /T3NBYR/ NBYTR
C
      DATA IDATA /0/
C
C
      CALL G3INIT(2)
C
      RTRAC1= ANGLE
      IF (IPRINT.EQ.1) CALL G0MESG(55,1)
C
      MRKSLP= 0
      STANG0= ANGLE*ANGCON
      RDATA(1)= STANG0
      CALL G3LINK(2,4,NBYTR,IDATA,RDATA)
C
      RETURN
      END
