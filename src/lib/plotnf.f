      SUBROUTINE PLOTNF(X,Y,VALUE,NAFTDP)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 172)   VERSION (A8.3)    11:FEB:87
C          ------------------------------------------------
C
C          THIS PLOTS OUT THE GIVEN VALUE IN REAL FORMAT.
C
C          THE ARGUMENTS ARE AS FOLLOWS:
C
C          <X,Y>    ARE THE COORDINATES OF THE DECIMAL POINT.
C          <VALUE>  IS THE VALUE TO BE PLOTTED.
C          <NAFTDP> IS THE NO. OF DIGITS AFTER THE DECIMAL POINT.
C
C
      REAL    RDATA(1)
      INTEGER IDATA(20)
      LOGICAL ERRON
C
      COMMON /T3ERRS/ ERRON,NUMERR
      COMMON /T3LIMS/ IMAXI,RMAXI,RMINI
C
      DATA ISPACE /32/, MINUS /45/, IPOINT /46/, IZERO /48/,
     &     RDATA /0.0/
C
C
C          THE ERROR EXIT IS TAKEN IF <NAFTDP> IS WRONG.
C          THE FIRST CHARACTER IS SET TO SPACE OR ZERO,
C          DEPENDING ON THE SIGN OF THE NUMBER.
C
      IF (NAFTDP.LE.0)  GO TO 901
      IF (NAFTDP.GT.17) GO TO 901
C
      CALL POSITN(X,Y)
      IDATA(1)= 2
      CALL G3LINK(2,17,-1,IDATA,RDATA)
      IDATA(1)= ISPACE
      IF (VALUE.LT.0.0) IDATA(1)= MINUS
C
C          THE NUMBER IS LEFT-SHIFTED BY <NAFTDP> PLACES THEN
C          ROUNDED. IF THIS RESULTS IN A ZERO NUMBER, THE SIGN
C          IS SUPPRESSED. IF THE NUMBER IS GREATER THAN UNITY,
C          A DECIMAL IPOINT IS INSERTED IN THE CHARACTER STRING
C          AT THE APPROPRIATE POSITION; IF IT IS FRACTIONAL,
C          AN INITIAL ZERO, A DECIMAL POINT, THEN AS MANY
C          FOLLOWING ZEROES AS NECESSARY ARE ADDED INSTEAD.
C
      ABVAL= ABS(VALUE)
      SHIFAC= 10.0**NAFTDP
      SHIFTD= ABVAL*SHIFAC
      IF (SHIFTD.GT.FLOAT(IMAXI)) GO TO 901
C
      IVALUE= SHIFTD+0.5
      IF (IVALUE.EQ.0) IDATA(1)= ISPACE
      IF (ABVAL.LT.1.0.AND.SHIFAC-SHIFTD.GT.0.5) GO TO 1
C
      INDEX= 2
      CALL G0CONI(IVALUE,IDATA,INDEX)
      NCHARS= INDEX-NAFTDP-1
      CALL G3LINK(2,11,-NCHARS,IDATA,RDATA)
      IDATA(1)= 0
      CALL G3LINK(2,17,-1,IDATA,RDATA)
      IDATA(1)= IPOINT
C
      DO 100 IMOVE= 1,NAFTDP
        IFROM= INDEX-NAFTDP+IMOVE-1
        IDATA(IMOVE+1)= IDATA(IFROM)
  100 CONTINUE
C
      GO TO 2
C
    1 IDATA(2)= IZERO
      CALL G3LINK(2,11,-2,IDATA,RDATA)
      IDATA(1)= 0
      CALL G3LINK(2,17,-1,IDATA,RDATA)
      IDATA(1)= IPOINT
      INDEX= 2
      CALL G0CONI(IVALUE,IDATA,INDEX)
C
      DO 200 IMOVE= 1,NAFTDP
        ITO= NAFTDP-IMOVE+2
        IFROM= INDEX-IMOVE
        IVALUE= IZERO
        IF (IFROM.GT.1) IVALUE= IDATA(IFROM)
C
        IDATA(ITO)= IVALUE
  200 CONTINUE
C
    2 CALL G3LINK(2,11,-NAFTDP-1,IDATA,RDATA)
      RETURN
C
  901 NUMERR= 30
      IF (ERRON) CALL G0ERMS
      RETURN
      END