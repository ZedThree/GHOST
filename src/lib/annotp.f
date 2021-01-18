      SUBROUTINE ANNOTP(IDIRX,IDIRY)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 239)   VERSION (A7.1)    11:FEB:85
C          ------------------------------------------------
C
C          THIS SETS THE POSITION OF AXIS ANNOTATION.
C
C
C          THE ARGUMENTS ARE:
C
C          <IDIRX>  DETERMINES THE POSITION OF THE X-AXIS ANNOTATION:
C                   = 0, IT IS BELOW THE X-AXIS (IE. NORMAL),
C                   = 1, IT IS ABOVE THE X-AXIS;
C          <IDIRY>  DETERMINES THE POSITION OF THE Y-AXIS ANNOTATION:
C                   = 0, IT IS LEFT OF THE Y-AXIS (IE. NORMAL),
C                   = 1, IT IS RIGHT OF THE Y-AXIS.
C
C
      COMMON /T0ANOD/ KDIRX,KDIRY
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
C
C
      CALL G3INIT(2)
C
      ITRAC1= IDIRX
      ITRAC2= IDIRY
      IF (IPRINT.EQ.1) CALL G0MESG(155,6)
C
      KDIRX= IDIRX
      KDIRY= IDIRY
C
      RETURN
      END
