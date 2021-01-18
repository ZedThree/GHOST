      SUBROUTINE MOVE(DX,DY)
C
C          ------------------------------------------------
C          ROUTINE NO. (  74)   VERSION (A7.3)    11:FEB:85
C          ------------------------------------------------
C
C          THIS CHANGES THE PEN POSITION BY (DX,DY).
C
C
      COMMON /T0PPOS/ XPLOT0,YPLOT0
C
C
      X= XPLOT0+DX
      Y= YPLOT0+DY
      CALL POSITN(X,Y)
C
      RETURN
      END
