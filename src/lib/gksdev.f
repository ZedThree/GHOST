      SUBROUTINE GKSDEV(NUMDEV)
C
C          ------------------------------------------------
C          ROUTINE NO. (  40)   VERSION (A8.1)    14:MAR:90
C          ------------------------------------------------
C
C          THIS SETS THE WORKSTATION TYPE FOR GKS.
C
      COMMON /T1DVCE/ IDEVCE
C
C
      IDEVCE= NUMDEV
C
      RETURN
      END
