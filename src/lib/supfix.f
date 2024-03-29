      SUBROUTINE SUPFIX
C
C          ------------------------------------------------
C          ROUTINE NO. ( 149)   VERSION (A8.5)    04:MAR:91
C          ------------------------------------------------
C
C          THIS SETS CONDITIONS FOR SUPERFIX CHARACTER STRINGS.
C
C
      REAL    RDATA(1)
      INTEGER IDATA(2)
      LOGICAL ERRON
C
      COMMON /T0CDIM/ MAGN0,OBLAT0
      COMMON /T0SUPF/ MAGBUF(5),MAGLVL
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
      COMMON /T3ERRS/ ERRON,NUMERR
C
      DATA RDATA(1) /0.0/
C
C
      ITRAC1= MAGLVL
      IF (IPRINT.EQ.1) CALL G0MESG(60,5)
C
C          THE BUFFER LEVEL IS TESTED FOR OVERFLOW:
C          IF SO, AN ERROR MESSAGE IS PRINTED;
C          OTHERWISE, THE BUFFER LEVEL IS INCREMENTED,
C          THE NEW MAGNIFICATION IS CALCULATED AND THEN SET.
C          THE SIGN OF THE MAGNIFICATION STORED IN THE BUFFER
C          INDICATES THAT THIS LEVEL WAS A SUPERFIX.
C
      IF (MAGLVL.GE.5) GO TO 901
C
      IPRSAV= IPRINT
      IPRINT= 0
C
      IDATA(1)= 8
      IDATA(2)= 1
      CALL G3LINK(2,12,-2,IDATA,RDATA)
      IDATA(1)= 4
      CALL G3LINK(2,12,-2,IDATA,RDATA)
C
      MAGLVL= MAGLVL+1
      MAGBUF(MAGLVL)= IABS(MAGN0)
      MAG= (MAGN0*5+4)/8
      CALL CTRMAG(MAG)
      IDATA(1)= 2
      CALL G3LINK(2,12,-2,IDATA,RDATA)
      IPRINT= IPRSAV
      RETURN
C
  901 NUMERR= 16
      IF (ERRON) CALL G0ERMS
C
      RETURN
      END
