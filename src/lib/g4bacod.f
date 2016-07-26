      SUBROUTINE G4BACO(NCHARI,NCHARO)
C
C          ------------------------------------------------
C          ROUTINE NO. (4001)   VERSION (A7.1D)   21:NOV:85
C          ------------------------------------------------
C
C          THIS TRANSLATES THE GIVEN CHAR. NO. <NCHARI>
C          FROM THE ASCII CHARACTER CODING INTO THE
C          EQUIVALENT CHAR. NO. <NCHARO> IN MACHINE CODE.
C
C          THIS VERSION IS FOR ASCII-CODED MACHINES.
C
C
      NCHARO= MOD(NCHARI,128)
      RETURN
      END
