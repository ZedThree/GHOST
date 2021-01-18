      SUBROUTINE PCSCEN(X,Y,PHRASE)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 164)   VERSION (A7.5)    11:FEB:85
C                         === FORTRAN-77 ===
C          ------------------------------------------------
C
C          THIS DRAWS THE CHARACTER STRING <PHRASE> WITH
C          THE MIDDLE CHARACTER PLACED AT THE POSITION <X,Y>.
C
C
      CHARACTER PHRASE*(*)
C
C
      CALL POSITN(X,Y)
      CALL TCSCEN(PHRASE)
C
      RETURN
      END
