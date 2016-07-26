      SUBROUTINE GPSTOP(LIMIT)
C
C          ------------------------------------------------
C          ROUTINE NO. (   6)   VERSION (A7.5)    11:FEB:85
C          ------------------------------------------------
C
C      THIS ALTERS THE FRAME LIMIT.
C
C
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
      COMMON /T2PNUM/ NGPICS,LIMPIC
C
C
      CALL G3INIT(2)
C
      ITRAC1= LIMIT
      IF (IPRINT.EQ.1) CALL G0MESG(5,5)
C
      LIMPIC= LIMIT
C
      RETURN
      END
