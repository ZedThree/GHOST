      PROGRAM INTERCA
C
C          -----------------------------------------------
C          ROUTINE NO. (5005)   VERSION (A8.1A)  13:NOV:90
C          -----------------------------------------------
C
C
      COMMON /T1CMLN/ NMFILE(32),LNFILE,ICMND(35,2)
C
C
      CALL G3INIT(1)
      CALL INTERP(NMFILE,ICMND(1,1))
      STOP ' '
      END
