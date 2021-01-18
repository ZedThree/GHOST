      SUBROUTINE PIEANG(ANGLE)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 108)   VERSION (A8.1)    24:NOV:86
C          ------------------------------------------------
C
C          THIS SETS THE ANGLE OF THE FIRST SECTOR OF A PIECHART.
C
C
C          <ANGLE>   IS THE FIRST SECTOR ANGLE.
C
C
      COMMON /T0ACON/ ANGCON
      COMMON /T0PIAN/ ANGPIE
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAR/ RTRAC1,RTRAC2,RTRAC3,RTRAC4
C
C
      CALL G3INIT(2)
C
      RTRAC1= ANGLE
      IF (IPRINT.EQ.1) CALL G0MESG(165,1)
C
      ANGPIE= ANGLE*ANGCON
C
      RETURN
      END
