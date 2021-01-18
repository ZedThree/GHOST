      SUBROUTINE ENQCHR(IPARAM,RPARAM)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 257)   VERSION (A7.3)    11:FEB:85
C          ------------------------------------------------
C
C          THIS RETURNS CURRENT CHARACTER PARAMETERS.
C
C
      REAL    RPARAM(9)
      INTEGER IPARAM(10)
C
C
      COMMON /T0CANG/ STANG0,CRANG0
      COMMON /T0CATT/ IUNDL0,ITAL0
      COMMON /T0CDIM/ MAGN0,OBLAT0
      COMMON /T0CFON/ KFONT0
      COMMON /T0CSIZ/ CSIZE,MRKSIZ
      COMMON /T0CSLO/ SLOPE,MRKSLP
      COMMON /T0CSPA/ X1CHR0,X2CHR0,Y1CHR0,Y2CHR0
      COMMON /T0CVIS/ KWIND0,KMASK0
      COMMON /T0HRDC/ KHRDW0
      COMMON /T0MRKS/ MARKC0
C
C
      IPARAM( 1)= KFONT0
      IPARAM( 2)= MAGN0
      IPARAM( 3)= MRKSIZ
      IPARAM( 4)= ITAL0
      IPARAM( 5)= IUNDL0
      IPARAM( 6)= MRKSLP
      IPARAM( 7)= MARKC0
      IPARAM( 8)= KWIND0
      IPARAM( 9)= KMASK0
      IPARAM(10)= KHRDW0
C
      RPARAM(1)= X1CHR0
      RPARAM(2)= X2CHR0
      RPARAM(3)= Y1CHR0
      RPARAM(4)= Y2CHR0
      RPARAM(5)= CSIZE
      RPARAM(6)= OBLAT0
      RPARAM(7)= STANG0
      RPARAM(8)= CRANG0
      RPARAM(9)= SLOPE
C
      RETURN
      END
