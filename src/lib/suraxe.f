      SUBROUTINE SURAXE(IAXIND,XORIGN,YORIGN,XDELTA,YDELTA)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 115)   VERSION (A7.1)    11:FEB:85
C          ------------------------------------------------
C
C          THIS SETS DETAILS OF THE AXIS ANNOTATION
C          FOR THE ROUTINE <SURPLT>.
C
C
C          THE ARGUMENTS ARE AS FOLLOWS:
C
C
C          <IAXIND>  IS THE AXIS ANNOTATION METHOD NUMBER.
C          <XORIGN>  AND
C          <YORIGN>  SPECIFY THE COORDINATES OF THE ORIGIN
C                    OF THE SURFACE ARRAY FOR METHODS 2 AND 3.
C          <XDELTA>  AND
C          <YDELTA>  SPECIFY THE STEP SIZES FOR THE SURFACE
C                    ARRAY FOR METHODS 2 AND 3.
C
      LOGICAL ERRON
C
      COMMON /T0SAXE/ INDAXE,XAXORG,YAXORG,XAXDEL,YAXDEL
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
      COMMON /T3ERRS/ ERRON,NUMERR
C
C
      CALL G3INIT(2)
C
      ITRAC1= IAXIND
      IF (IPRINT.EQ.1) CALL G0MESG(158,5)
C
      IF (IAXIND.LT.0.OR.IAXIND.GT.3) GO TO 901
C
      INDAXE= IAXIND
      IF (INDAXE.EQ.0) RETURN
C
      XAXORG= XORIGN
      YAXORG= YORIGN
      XAXDEL= XDELTA
      YAXDEL= YDELTA
      RETURN
C
  901 NUMERR= 39
      IF (ERRON) CALL G0ERMS
      RETURN
      END
