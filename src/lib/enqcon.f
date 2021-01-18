      SUBROUTINE ENQCON(IPARAM)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 251)   VERSION (A7.3)    11:FEB:85
C          ------------------------------------------------
C
C          THIS RETURNS CURRENT CONTROL PARAMETERS.
C
C
      INTEGER IPARAM(11)
C
C
      COMMON /T0ACON/ ANGCON
      COMMON /T0BUFN/ KBUFR0
      COMMON /T0DEVS/ KCHAN0(5),IRESL0
      COMMON /T0TRAC/ IPRINT
      COMMON /T2PNUM/ NGPICS,LIMPIC
      COMMON /T3MODE/ KMODE
C
C
      IANGTP= 3
      IF (ANGCON.GT.0.016) IANGTP= 2
      IF (ANGCON.GT.0.020) IANGTP= 1
      IF (ANGCON.GT.1.5)   IANGTP= 4
C
      IPARAM( 1)= NGPICS
      IPARAM( 2)= LIMPIC
      IPARAM( 3)= KBUFR0
      IPARAM( 4)= IPRINT
      IPARAM( 5)= IANGTP
      IPARAM( 6)= KCHAN0(1)
      IPARAM( 7)= KCHAN0(2)
      IPARAM( 8)= KCHAN0(3)
      IPARAM( 9)= KCHAN0(4)
      IPARAM(10)= KCHAN0(5)
      IPARAM(11)= KMODE
C
      RETURN
      END
