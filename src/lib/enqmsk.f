      SUBROUTINE ENQMSK(IPARAM,RPARAM)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 253)   VERSION (A7.3)    11:FEB:85
C          ------------------------------------------------
C
C          THIS RETURNS THE CURRENT MASKING PARAMETERS.
C
C
      REAL    RPARAM(40)
      INTEGER IPARAM(1)
C
C
      COMMON /T0MASK/ X1MSK0(10),X2MSK0(10),Y1MSK0(10),Y2MSK0(10),MSKLV0
C
C
      IPARAM(1)= MSKLV0
C
      DO 100 LEVEL= 1,10
        INDEXL= 4*(LEVEL-1)
        RPARAM(INDEXL+1)= X1MSK0(LEVEL)
        RPARAM(INDEXL+2)= X2MSK0(LEVEL)
        RPARAM(INDEXL+3)= Y1MSK0(LEVEL)
        RPARAM(INDEXL+4)= Y2MSK0(LEVEL)
  100 CONTINUE
C
      RETURN
      END
