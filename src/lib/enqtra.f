      SUBROUTINE ENQTRA(IPARAM,RPARAM)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 254)   VERSION (A7.3)    11:FEB:85
C          ------------------------------------------------
C
C          THIS RETURNS THE CURRENT PICTURE TRANSFORMATION PARAMETERS.
C
C
      REAL    RPARAM(11)
      INTEGER IPARAM(3)
      LOGICAL SHIFT0
C
      COMMON /T0TRAN/ SCALX0,SCALY0,ROTAT0,RPICX0,RPICY0,RDEVX0,RDEVY0,
     &                VRPICX,VRPICY,VRDEVX,VRDEVY
      COMMON /T0TRST/ SHIFT0,MTRAN0,KLIPM0
C
C
      IPARAM(1)= 0
      IF (SHIFT0) IPARAM(1)= 1
      IPARAM(2)= MTRAN0
      IPARAM(3)= KLIPM0
C
      RPARAM( 1)= SCALX0
      RPARAM( 2)= SCALY0
      RPARAM( 3)= ROTAT0
      RPARAM( 4)= VRPICX
      RPARAM( 5)= VRPICY
      RPARAM( 6)= VRDEVX
      RPARAM( 7)= VRDEVY
      RPARAM( 8)= RPICX0
      RPARAM( 9)= RPICY0
      RPARAM(10)= RDEVX0
      RPARAM(11)= RDEVY0
C
      RETURN
      END
