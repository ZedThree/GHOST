      SUBROUTINE AXINTS(NOINTS)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 241)   VERSION (A8.1)    01:MAR:93
C          ------------------------------------------------
C
C          THIS SETS THE MAXIMUM NUMBER OF ANNOTATED
C          INTERVALS ON AN AXIS.
C
C
C          <NOINTS> SETS THE NUMBER OF INTERVALS:
C                   IF NON-ZERO, THE ABSOLUTE VALUE IS TAKEN.
C                   IF ZERO, THE DEFAULT OF 15 IS SET.
C
C
      COMMON /T0ATIC/ MTICKS
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
C
C
      CALL G3INIT(2)
C
      ITRAC1= NOINTS
      IF (IPRINT.EQ.1) CALL G0MESG(29,5)
C
      MTICKS= ABS(NOINTS)
      IF (MTICKS.EQ.0) MTICKS= 15
C
      RETURN
      END
