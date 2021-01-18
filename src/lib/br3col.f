      SUBROUTINE BR3COL(IMETHD)
C
C          ------------------------------------------------
C          ROUTINE NO. (  42)   VERSION (A8.1)    02:JUL:86
C          ------------------------------------------------
C
C          THIS ROUTINE SETS UP THE METHOD OF COLOURING USED
C          BY THE THREE DIMENSIONAL BARCHART ROUTINE.
C
C          THE PARAMETER IS :
C
C          <IMETHD> IS AN INTEGER REFERING TO THE METHOD OF
C                   COLOURING :
C                           0 : NO COLOURING TO BE DONE.
C                           1 : EACH X BAR DIFFERENT COLOUR.
C                           2 : EACH Y BAR DIFFERENT COLOUR.
C                           3 : EACH SURFACE OF BAR DIFFERENT
C                               COLOUR.
C                           4 : EACH BAR DIFFERENT COLOUR.
C
      COMMON /T0BKLM/ KMTHOD
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
C
C
      CALL G3INIT(2)
      ITRAC1= IMETHD
      IF (IPRINT.EQ.1) CALL G0MESG(172,5)
      IF (IMETHD.LT.0.OR.IMETHD.GT.4) RETURN
C
      KMTHOD= IMETHD
C
      RETURN
      END
