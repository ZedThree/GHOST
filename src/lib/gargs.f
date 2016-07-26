      SUBROUTINE GARGS(ITRACE)
C
C          ------------------------------------------------
C          ROUTINE NO. (   7)   VERSION (A7.3)    11:FEB:85
C          ------------------------------------------------
C
C          THIS SETS THE TRACE MARKER, HENCE ENABLING
C          OR DISABLING THE PRINTING OF TRACE DIAGNOSTICS.
C
C
C          <ITRACE> IS THE CONTROL VARIABLE:
C                   IF ZERO, MESSAGES ARE NOT GIVEN,
C                   IF NON-ZERO, MESSAGES ARE PRINTED.
C
C
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
C
C
      CALL G3INIT(2)
C
      ITRAC1= ITRACE
      CALL G0MESG(6,5)
C
      IPRINT= 0
      IF (ITRACE.NE.0) IPRINT= 1
C
      RETURN
      END
