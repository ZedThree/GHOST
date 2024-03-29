      SUBROUTINE G3GRIN(ICOMND,XLOCV,YLOCV,XLOCN,YLOCN,NREPC)
C
C          ------------------------------------------------
C          ROUTINE NO. (3004)   VERSION (A7.1A)   11:FEB:85
C          ------------------------------------------------
C
C          THIS PROVIDES GRAPHICAL INPUT FACILITIES.
C          (THIS VERSION IS FOR DEVICES WITHOUT GRAPHICAL INPUT).
C
C
C          THE ARGUMENTS ARE AS FOLLOWS:
C
C          <ICOMND> SETS THE INPUT ACTION:
C                   = 1, THE DEVICE CURSOR IS ACTIVATED,
C                   = 2, THE LOCATOR POSITIONS ARE RETURNED;
C          <XLOCV>  IS THE LOCATOR X-COORDINATE IN VECTOR SPACE;
C          <YLOCV>  IS THE LOCATOR Y-COORDINATE IN VECTOR SPACE;
C          <XLOCN>  IS THE LOCATOR X-COORDINATE IN ND-SPACE;
C          <YLOCN>  IS THE LOCATOR Y-COORDINATE IN ND-SPACE;
C          <NREPC>  IS THE (GHOST) REPLY CHARACTER NUMBER.
C
C
      LOGICAL GFOPEN,PPOPEN
C
      COMMON /T1PPBT/ XPLOTB,YPLOTB
      COMMON /T1PPOS/ XPLOT1,YPLOT1
      COMMON /T1REPN/ NREPLC
      COMMON /T3OUTS/ GFOPEN,PPOPEN
C
C
      IF (.NOT.PPOPEN) RETURN
      IF (ICOMND.EQ.2) GO TO 1
C
C          THE DEVICE CURSOR CANNOT BE ACTIVATED WITH THIS VERSION.
C          AN EXCLAMATION MARK IS GIVEN AS THE REPLY CHARACTER.
C
      NREPLC= 33
      RETURN
C
C          IN THIS VERSION, THE CURRENT PLOTTING POSITIONS ARE GIVEN.
C
    1 XLOCV= XPLOT1
      YLOCV= YPLOT1
      XLOCN= XPLOTB
      YLOCN= YPLOTB
      NREPC= NREPLC
C
      RETURN
      END
