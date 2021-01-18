      SUBROUTINE MOVEPT(DX,DY)
C
C          ------------------------------------------------
C          ROUTINE NO. (  75)   VERSION (A7.3)    11:FEB:85
C          ------------------------------------------------
C
C          THIS DRAWS A POINT AFTER MOVING THE PEN BY (DX,DY).
C
C
      COMMON /T0PPOS/ XPLOT0,YPLOT0
C
C
      X= XPLOT0+DX
      Y= YPLOT0+DY
      CALL POINT(X,Y)
C
      RETURN
      END
