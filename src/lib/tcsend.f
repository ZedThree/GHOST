      SUBROUTINE TCSEND(PHRASE)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 161)   VERSION (A8.6)    23:JAN:86
C                         === FORTRAN-77 ===
C          ------------------------------------------------
C
C          THIS DRAWS THE CHAR. STRING <PHRASE> WITH THE RIGHTMOST
C          CHARACTER LOCATED ONE PLACE BEFORE THE CURRENT POSITION.
C
C
      REAL      RDATA(1)
      INTEGER   IDATA(1)
      CHARACTER PHRASE*(*)
C
      DATA RDATA /0.0/
C
C
      IDATA(1)= 2
      CALL G3LINK(2,17,-1,IDATA,RDATA)
      CALL TYPECS(PHRASE)
      IDATA(1)= 0
      CALL G3LINK(2,17,-1,IDATA,RDATA)
C
      RETURN
      END
