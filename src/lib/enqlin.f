      SUBROUTINE ENQLIN(IPARAM)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 255)   VERSION (A7.4)    11:FEB:85
C          ------------------------------------------------
C
C          THIS RETURNS CURRENT LINE-TYPE PARAMETERS.
C
C
      INTEGER IPARAM(8)
C
C
      COMMON /T0CURV/ MCURV0
      COMMON /T0HRDL/ LHRDW0
      COMMON /T0LATT/ KOLIN0,ITHIK0
      COMMON /T0LPAT/ MARKA0,MISSA0,MARKB0,MISSB0
C
C
      IPARAM(1)= MCURV0
      IPARAM(2)= ITHIK0
      IPARAM(3)= KOLIN0
      IPARAM(4)= MARKA0
      IPARAM(5)= MISSA0
      IPARAM(6)= MARKB0
      IPARAM(7)= MISSB0
      IPARAM(8)= LHRDW0
C
      RETURN
      END
