      SUBROUTINE MAPFOL
C
C          ------------------------------------------------
C          ROUTINE NO. (  38)   VERSION (A7.3)    11:FEB:85
C          ------------------------------------------------
C
C          THIS REPLACES THE MAP BY THE WINDOW AREA.
C
C
      COMMON /T0MACT/ MRKMAP,MRKWIN
      COMMON /T0TRAC/ IPRINT
      COMMON /T0WNDO/ X1WND0,X2WND0,Y1WND0,Y2WND0
C
C
      CALL G3INIT(2)
C
      IF (IPRINT.EQ.1) CALL G0MESG(125,0)
C
      IF (MRKMAP.EQ.0) RETURN
      CALL G0MAPS(X1WND0,X2WND0,Y1WND0,Y2WND0)
      MRKMAP= 0
C
      RETURN
      END
