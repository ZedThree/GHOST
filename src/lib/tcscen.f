      SUBROUTINE TCSCEN(PHRASE)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 160)   VERSION (A8.6)    23:JAN:86
C                         === FORTRAN-77 ===
C          ------------------------------------------------
C
C          THIS DRAWS THE CHARACTER STRING <PHRASE> WITH THE
C          MIDDLE CHARACTER PLACED AT THE CURRENT CHAR. POSITION.
C
C
      REAL      RDATA(1)
      INTEGER   IDATA(1)
      CHARACTER PHRASE*(*)
C
      DATA RDATA /0.0/
C
C
      IDATA(1)= 1
      CALL G3LINK(2,17,-1,IDATA,RDATA)
      CALL TYPECS(PHRASE)
      IDATA(1)= 0
      CALL G3LINK(2,17,-1,IDATA,RDATA)
C
      RETURN
      END
