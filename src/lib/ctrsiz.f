      SUBROUTINE CTRSIZ(SIZE)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 143)   VERSION (A8.5)    18:APR:88
C          ------------------------------------------------
C
C          THIS SETS THE CURRENT CHARACTER SIZE IN UNITS OF
C          1/1000 OF THE PLOTTER-SPACE Y-AXIS SIDE LENGTH).
C
C
      COMMON /T0CDIM/ MAGN0,OBLAT0
      COMMON /T0CSIZ/ CSIZE,MRKSIZ
      COMMON /T0MAPP/ X1MAP0,X2MAP0,Y1MAP0,Y2MAP0
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAR/ RTRAC1,RTRAC2,RTRAC3,RTRAC4
C
C
      CALL G3INIT(2)
      RTRAC1= SIZE
      IF (IPRINT.EQ.1) CALL G0MESG(54,1)
C
      IPRSAV= IPRINT
      IPRINT= 0
      CSIZE= SIZE
      MAGN0= MIN1(255.0,ABS(CSIZE*1000.0/(Y2MAP0-Y1MAP0))+0.5)
      CALL CTRMAG(MAGN0)
      MRKSIZ= 1
      IPRINT= IPRSAV
C
      RETURN
      END
