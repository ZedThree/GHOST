      SUBROUTINE ENQIOC(IPARAM)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 260)   VERSION (A7.3)    11:FEB:85
C          ------------------------------------------------
C
C          THIS RETURNS CURRENT I/O CHANNEL NUMBERS.
C
C
      INTEGER IPARAM(4)
C
C
      COMMON /T1CHAD/ KDISPI,KDISPO
      COMMON /T3CHAM/ KMESGI,KMESGO
C
C
      IPARAM(1)= KMESGI
      IPARAM(2)= KMESGO
      IPARAM(3)= KDISPI
      IPARAM(4)= KDISPO
C
      RETURN
      END
