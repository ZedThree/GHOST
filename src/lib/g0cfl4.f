      SUBROUTINE G0CFL4(VP,VQ,CLEVLS,ISTRTL,ISTOPL,NINTS)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 188)   VERSION (A8.1)    22:APR:91
C          ------------------------------------------------
C
C          THIS FINDS THE NUMBER OF CONTOURS THAT INTERSECT A LINE.
C
C
      REAL CLEVLS(ISTOPL)
C
C
      VLO= AMIN1(VP,VQ)
      VHI= AMAX1(VP,VQ)
      NINTS= 0
C
      DO 100 I= ISTRTL,ISTOPL
        IF (VLO.LT.CLEVLS(I).AND.VHI.GT.CLEVLS(I)) NINTS= NINTS+1
  100 CONTINUE
C
      RETURN
      END
