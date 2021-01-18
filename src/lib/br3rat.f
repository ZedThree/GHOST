      SUBROUTINE BR3RAT(BSRATO)
C
C          ------------------------------------------------
C          ROUTINE NO. (  49)   VERSION (A8.1)    30:SEP:86
C          ------------------------------------------------
C
C          THIS SETS THE BAR:SPACE RATIO FOR THE ROUTINE BAR3D
C
C          THE PARAMETER IS :
C
C          <BSRATO> IS THE RATIO OF THE BARSIZE AND THE SPACES
C                   BETWEEN THEM.
C
C
      COMMON /T0BASP/ SIZRAT
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAR/ RTRAC1,RTRAC2,RTRAC3,RTRAC4
C
C
      CALL G3INIT(2)
      RTRAC1= BSRATO
      IF (IPRINT.EQ.1) CALL G0MESG(175,1)
C
      SIZRAT= BSRATO
      SIZRAT= AMIN1(SIZRAT,0.99999)
      SIZRAT= AMAX1(SIZRAT,0.00001)
C
      RETURN
      END
