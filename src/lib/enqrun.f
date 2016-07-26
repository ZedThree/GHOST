      SUBROUTINE ENQRUN(IPARAM)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 262)   VERSION (A7.3)    11:FEB:85
C          ------------------------------------------------
C
C          THIS INDICATES THE AVAILABILITY OF THE
C          TWO OUTPUT STREAMS OF THE GHOST SYSTEM.
C
C
      INTEGER IPARAM(2)
C
      COMMON /T3SHUT/ K1ERR,K2ERR
C
C
      IPARAM(1)= K1ERR
      IPARAM(2)= K2ERR
C
      RETURN
      END
