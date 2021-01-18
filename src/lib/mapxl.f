      SUBROUTINE MAPXL(XAREA1,XAREA2,YAREA1,YAREA2)
C
C          ------------------------------------------------
C          ROUTINE NO. (  22)   VERSION (A7.4)    11:FEB:85
C          ------------------------------------------------
C
C          THIS CALLS <G0MAPS> TO SET LOG.-X, LIN.-Y MAPPING.
C
C
C          <XAREA1,YAREA1> IS THE BOTTOM-LEFT AND
C          <XAREA2,YAREA2> IS THE TOP-RIGHT CORNER.
C
C
      COMMON /T0AUTM/ MAPNUM
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAR/ RTRAC1,RTRAC2,RTRAC3,RTRAC4
C
C
      CALL G3INIT(2)
C
      RTRAC1= XAREA1
      RTRAC2= XAREA2
      RTRAC3= YAREA1
      RTRAC4= YAREA2
      IF (IPRINT.EQ.1) CALL G0MESG(8,4)
C
      MAPNUM= 3
      CALL G0MAPS(XAREA1,XAREA2,YAREA1,YAREA2)
C
      RETURN
      END
