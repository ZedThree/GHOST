      SUBROUTINE WINFOL
C
C          ------------------------------------------------
C          ROUTINE NO. (  39)   VERSION (A7.3)    11:FEB:85
C          ------------------------------------------------
C
C          THIS REPLACES THE WINDOW BY THE MAP AREA.
C
C
      COMMON /T0MACT/ MRKMAP,MRKWIN
      COMMON /T0MAPA/ X1MAPV,X2MAPV,Y1MAPV,Y2MAPV
      COMMON /T0TRAC/ IPRINT
C
C
      CALL G3INIT(2)
C
      IF (IPRINT.EQ.1) CALL G0MESG(126,0)
C
      IF (MRKWIN.EQ.0) RETURN
      CALL WINDOW(X1MAPV,X2MAPV,Y1MAPV,Y2MAPV)
      MRKWIN= 0
C
      RETURN
      END
