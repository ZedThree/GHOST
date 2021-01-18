      SUBROUTINE FILCOL(NCOLOR)
C
C          ------------------------------------------------
C          ROUTINE NO. (  67)   VERSION (A8.2)    02:JUN:87
C          ------------------------------------------------
C
C          THIS SETS THE CURRENT AREA-FILL COLOUR.
C
C
C          THE ARGUMENT IS AS FOLLOWS:
C
C          <NCOLOR> IS THE REQUIRED COLOUR NUMBER.
C
C
      COMMON /T0KFIL/ KOLFL0
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
C
C
      CALL G3INIT(2)
      ITRAC1= NCOLOR
      IF (IPRINT.EQ.1) CALL G0MESG(132,5)
      IF (IABS(NCOLOR).GT.255) RETURN
C
      KOLFL0= NCOLOR
C
      RETURN
      END
