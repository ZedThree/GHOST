      SUBROUTINE CRETRN
C
C          ------------------------------------------------
C          ROUTINE NO. ( 180)   VERSION (A8.4)    24:NOV:86
C          ------------------------------------------------
C
C          THIS DOES A CARRIAGE-RETURN IN CHARACTER SPACE.
C
C
      REAL    RDATA(1)
      INTEGER IDATA(2)
      LOGICAL ERRON
C
      COMMON /T0CSPA/ X1CHR0,X2CHR0,Y1CHR0,Y2CHR0
      COMMON /T0TRAC/ IPRINT
      COMMON /T3ERRS/ ERRON,NUMERR
      COMMON /T3LIMS/ IMAXI,RMAXI,RMINI
C
      DATA RDATA /0.0/, IDATA /9,1/
C
C
      IF (IPRINT.EQ.1) CALL G0MESG(121,0)
      IF (ABS(X2CHR0-X1CHR0).LT.RMINI.OR.
     &    ABS(Y2CHR0-Y1CHR0).LT.RMINI) GO TO 901
C
      CALL G3LINK(2,12,-2,IDATA,RDATA)
      RETURN
C
  901 NUMERR= 27
      IF (ERRON) CALL G0ERMS
C
      RETURN
      END
