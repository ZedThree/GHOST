      SUBROUTINE G0GPOS(XGRIDS,YGRIDS,NPTSX,NPTSY,XIND,YIND,GPOSX,GPOSY)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 113)   VERSION (A7.1)    11:FEB:85
C          ------------------------------------------------
C
C          THIS FINDS THE INTERPOLATED COORDINATES ON A 'TARTAN' GRID.
C
C
C          THE ARGUMENTS ARE AS FOLLOWS:
C
C          [XGRIDS] ARE THE GRID X-POSITIONS.
C          [YGRIDS] ARE THE GRID Y-POSITIONS.
C          <NPTSX>  IS THE ACTUAL ARRAY X-EXTENT, AND
C          <NPTSY>  IS THE ACTUAL ARRAY Y-EXTENT.
C          XIND     IS THE INTERPOLATED X INDEX, AND
C          YIND     IS THE INTERPOLATED Y INDEX.
C          GPOSX    IS THE RETURNED X POSITION, AND
C          GPOSY    IS THE RETURNED Y POSITION.
C
C
      REAL XGRIDS(NPTSX),YGRIDS(NPTSY)
C
C
      GPOSX= XGRIDS(NPTSX)
      INTX= INT(XIND)
      IF (INTX.LT.NPTSX) GPOSX= XGRIDS(INTX)+AMOD(XIND,1.0)*
     &                          (XGRIDS(INTX+1)-XGRIDS(INTX))
C
      GPOSY= YGRIDS(NPTSY)
      INTY= INT(YIND)
      IF (INTY.LT.NPTSY) GPOSY= YGRIDS(INTY)+AMOD(YIND,1.0)*
     &                          (YGRIDS(INTY+1)-YGRIDS(INTY))
C
      RETURN
      END
