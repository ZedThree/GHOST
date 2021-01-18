      SUBROUTINE ENQERR(IPARAM)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 259)   VERSION (A7.3)    11:FEB:85
C          ------------------------------------------------
C
C          THIS RETURNS THE LATEST ERROR NUMBER
C          AND RESETS IT TO THE 'NO-ERROR' STATE.
C
C
      INTEGER IPARAM(1)
      LOGICAL ERRON
C
      COMMON /T3ERRS/ ERRON,NUMERR
C
C
      IPARAM(1)= NUMERR
      NUMERR= 0
C
      RETURN
      END
