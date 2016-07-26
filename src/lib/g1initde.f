      SUBROUTINE G1INIT(ITYPE)
C
C          ------------------------------------------------
C          ROUTINE NO. (1001)   VERSION (A8.3DE)  12:DEC:86
C          ------------------------------------------------
C
C          THIS INITIALISES DEVICE-DEPENDENT VARIABLES.
C          (THIS VERSION IS FOR THE GRID DECODER).
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
      LOGICAL   DONE
      LOGICAL   PREADY
C
      COMMON /T1DEBB/ PREADY,LINLIM,LINNUM,KNAML
      COMMON /T1DECC/ KFILEN(128)
C
      SAVE DONE
C
      DATA DONE /.FALSE./
C
C
       IF (ITYPE.LT.1.OR.ITYPE.GT.2) RETURN
       IF (DONE.AND.ITYPE.EQ.2)      RETURN
C
C          THIS PART INITIALISES THE DEVICE COMMON BLOCKS:
C
      PREADY= .TRUE.
      LINLIM= 42
      LINNUM= 1
      KNAML= 0
C
C          <G1HRDW> PERFORMS DEVICE INITIALISATION.
C
      IF (.NOT.DONE) CALL G1HRDW(0)
C
      DONE= .TRUE.
      RETURN
      END
