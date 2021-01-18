      SUBROUTINE G1INIT(ITYPE)
C
C          ------------------------------------------------
C          ROUTINE NO. (1001)   VERSION (A8.3TG)  12:DEC:86
C          ------------------------------------------------
C
C          THIS INITIALISES DEVICE-DEPENDENT VARIABLES.
C          (THIS VERSION IS FOR THE TRANGRID-80 ENCODER)
C
C     ******************************************************************
C     *                                                                *
C     *    NOTE: ALL GHOST DEVICE-DEPENDENT COMMON BLOCKS ARE          *
C     *          SPECIFIED HERE. TO ENSURE THEIR INTEGRITY IT IS       *
C     *          ESSENTIAL THAT THIS ROUTINE CANNOT BE SWAPPED-OUT.    *
C     *                                                                *
C     ******************************************************************
C
C
C          <ITYPE> CONTROLS THE ACTION AS FOLLOWS:
C
C          =  1, INITIALISATION IS DONE UNCONDITIONALLY.
C          =  2, INITIALISATION IS DONE ONLY IF NOT ALREADY DONE.
C
C
      LOGICAL DONE
      LOGICAL PREADY
C
      COMMON /T1TRAA/ ICODEB(26),INDXB
      COMMON /T1TRBB/ RFUNOB(64),IFUNOB(257)
      COMMON /T1TRFN/ KFILEN(128)
      COMMON /T1TRSV/ PREADY,KNAML
C
      SAVE DONE
C
      DATA DONE /.FALSE./
C
C
      IF (ITYPE.LT.1.OR.ITYPE.GT.2) RETURN
      IF (DONE)                     RETURN
C
C          THE OUTPUT BUFFER SIZE AND POINTER ARE SET. (THE
C          DECLARED SIZE OF [ICODEB] SHOULD BE LARGE ENOUGH):
C
      INDXB= 1
C
C          THIS PART INITIALISES THE DEVICE COMMON BLOCKS:
C
      KNAML= 0
      PREADY= .TRUE.
C
C          <G1HRDW> PERFORMS DEVICE INITIALISATION.
C
      CALL G1HRDW(0)
C
      DONE= .TRUE.
      RETURN
      END
