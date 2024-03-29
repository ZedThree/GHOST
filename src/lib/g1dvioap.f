      SUBROUTINE G1DVIO(ICOMND,IDATA,NCHRS)
C
C          ------------------------------------------------
C          ROUTINE NO. (1005)   VERSION (A8.1AP)  15:NOV:90
C          ------------------------------------------------
C
C          THIS INTERFACES DEVICE I/O WITH THE SYSTEM.
C          (THIS VERSION IS FOR ADOBE POSTSCRIPT).
C
C
C          THE ARGUMENTS ARE AS FOLLOWS:
C
C          <ICOMND> SETS THE I/O OPERATION:
C                   = 1, THE I/O CHANNELS ARE OPENED,
C                   = 2, THE I/O CHANNELS ARE CLOSED,
C                   = 3, THE OUTPUT BUFFER IS WRITTEN.
C          <IDATA>  IS THE CHARACTER I/O STRING.
C          <NCHRS>  IS THE NUMBER OF CHARS. IN THE STRING.
C
      INTEGER   IDATA(NCHRS)
      LOGICAL   EXISTS
      CHARACTER PRBUFF*512
      CHARACTER NAMAPS*128,CHCMND*128
C
      COMMON /T1APSL/ LENAPS
      COMMON /T1APSN/ NAMAPS
      COMMON /T1CHAD/ KDISPI,KDISPO
      COMMON /T1CMLC/ CHCMND(10)
      COMMON /T1CMLN/ NMFILE(32),LNFILE,ICMND(35,2)
C
C
      IF (ICOMND.NE.1) GO TO 4
C
      KDISPO= 20
      IF (ICMND(26,1).EQ.1) GO TO 2
C
      INQUIRE(FILE=NAMAPS(1:LENAPS),EXIST=EXISTS)
      IF (.NOT.EXISTS) GO TO 1
C
      OPEN(UNIT=KDISPO,FILE=NAMAPS(1:LENAPS),STATUS='OLD')
      CLOSE(UNIT=KDISPO,STATUS='DELETE')
    1 OPEN(UNIT=KDISPO,FILE=NAMAPS(1:LENAPS),STATUS='NEW')
      RETURN
C
    2 INQUIRE(FILE=CHCMND(1),EXIST=EXISTS)
      IF (.NOT.EXISTS) GO TO 3
C
      OPEN(UNIT=KDISPO,FILE=CHCMND(1),STATUS='OLD')
      CLOSE(UNIT=KDISPO,STATUS='DELETE')
    3 OPEN(UNIT=KDISPO,FILE=CHCMND(1),STATUS='NEW')
      RETURN
C
    4 IF (ICOMND.NE.2) GO TO 5
C
      CLOSE(UNIT=KDISPO)
      RETURN
C
    5 IF (ICOMND.NE.3) RETURN
C
C          THIS SECTION DOES DEVICE OUTPUT
C
      DO 100 IOUT= 1,NCHRS
        CALL G4BACO(IDATA(IOUT),KCHAR)
        PRBUFF(IOUT:IOUT)= CHAR(KCHAR)
  100 CONTINUE
C
      WRITE(KDISPO,201) PRBUFF(1:NCHRS)
  201 FORMAT(A)
      RETURN
      END
