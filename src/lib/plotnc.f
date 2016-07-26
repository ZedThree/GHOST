      SUBROUTINE PLOTNC(X,Y,ICHAR)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 162)   VERSION (A7.2)    11:FEB:85
C          ------------------------------------------------
C
C          THIS DRAWS CHARACTER NO. <ICHAR> AT POSITION <X,Y>.
C
C
      CALL POSITN(X,Y)
      CALL TYPENC(ICHAR)
      CALL SPACE(-1)
C
      RETURN
      END
