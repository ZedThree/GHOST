      SUBROUTINE POINT(X,Y)
C
C          ------------------------------------------------
C          ROUTINE NO. (  72)   VERSION (A7.3)    11:FEB:85
C          ------------------------------------------------
C
C          THIS MOVES THE PEN TO (X,Y) THEN MAKES A POINT.
C
      REAL    RDATA(1)
      INTEGER IDATA(1)
C
      DATA RDATA /0.0/, IDATA /0/
C
C
      CALL POSITN(X,Y)
      CALL G3LINK(0,1,0,IDATA,RDATA)
C
      RETURN
      END
