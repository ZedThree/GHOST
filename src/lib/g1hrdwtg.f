      SUBROUTINE G1HRDW(ICODE)
C
C          ------------------------------------------------
C          ROUTINE NO. (1002)   VERSION (A8.2TG)  15:NOV:90
C          ------------------------------------------------
C
C          THIS SETS HARDWARE-IMPLEMENTED FACILITIES.
C          (THIS VERSION IS FOR THE TRANGRID-80 ENCODER)
C
C          <ICODE> DETERMINES THE HARDWARE FUNCTION REQUIRED:
C
C                  =  0, DEVICE INITIALISATION IS DONE
C
C
      INTEGER IDUMMY(1)
C
      DATA IDUMMY /0/
C
C
      IF (ICODE.NE.0) RETURN
C
C          THIS SECTION DOES DEVICE INITIALISATION.
C
      CALL G1CMLN
      CALL G1DVIO(1,IDUMMY,1)
C
      RETURN
      END
