      SUBROUTINE PLOTST(X,Y,PHRASE)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 181)   VERSION (A7.3)    11:FEB:85
C                         === FORTRAN-77 ===
C          ------------------------------------------------
C
C          THIS DRAWS THE CHARACTER STRING STORED IN <PHRASE>
C          WITH THE LEFTMOST CHARACTER PLACED AT THE POSITION
C          <X,Y>. COMMAND STRINGS MAY BE EMBEDDED IN THE TEXT.
C
C
      CHARACTER PHRASE*(*)
C
      CALL POSITN(X,Y)
      CALL TYPEST(PHRASE)
C
      RETURN
      END
