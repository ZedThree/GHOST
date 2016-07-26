      INTEGER FUNCTION LENSTR(TEXT)
*-----------------------------------------------------------------------
* N.J. Brealey, March 2001

* Compute length of string ignoring trailing spaces

      IMPLICIT NONE

* Dummy arguments.

      CHARACTER*(*)         TEXT

* Local variables.

      INTEGER IMAX
      INTEGER I

*-----------------------------------------------------------------------

      LENSTR = 0
      IMAX = LEN(TEXT)
      IF (IMAX .LE. 0) RETURN
      IF (TEXT .EQ. ' ') RETURN
      DO 100 I = IMAX,1,-1
        LENSTR = I
        IF (TEXT(I:I) .NE. ' ') RETURN
 100  CONTINUE
C   should never reach here
      END

