       SUBROUTINE PIECHT(XORIG,YORIG,RADIUS,VALUES,NSECS)
C
C          ------------------------------------------------
C          ROUTINE NO. (  86)   VERSION (A8.3)    21:MAR:86
C          ------------------------------------------------
C
C          THIS DRAWS THE PIECHART SECTOR BY SECTOR.
C
C          THE ARGUMENTS ARE AS FOLLOWS:
C
C          <XORIG>  IS THE X-ORIGIN OF THE PIECHART,
C          <YORIG>  IS THE Y-ORIGIN OF THE PIECHART,
C          <RADIUS> IS THE RADIUS OF THE PIECHART,
C          [VALUES] IS AN ARRAY CONTAINING THE SIZES OF THE SECTORS
C                   IF > 0, THE SECTOR IS CENTRED
C                   IF < 0, THE SECTOR IS SHIFTED OUT,
C          <NSECS>  THE NUMBER OF SECTORS.
C
      REAL    VALUES(NSECS),XAUTO(2),YAUTO(2)
C
      COMMON /T0ACON/ ANGCON
      COMMON /T0KFIL/ KOLFL0
      COMMON /T0KLST/ LSTCL0(100),LENLST
      COMMON /T0MAPP/ X1MAP0,X2MAP0,Y1MAP0,Y2MAP0
      COMMON /T0PIAN/ ANGPIE
      COMMON /T0PIE/  XCPIE,YCPIE,PIEVAL(50),NPVALS,PIERAD,PIETOT,SIZLIM
      COMMON /T0PPOS/ XPLOT0,YPLOT0
      COMMON /T0TRAC/ IPRINT
      COMMON /T3CONS/ PI
C
C
      IF (IPRINT.EQ.1) CALL G0MESG(136,0)
C
      NPVALS= 0
      IF (NSECS.LE.0) RETURN
C
      IPRSAV= IPRINT
      IPRINT= 0
      ABSRAD= ABS(RADIUS)
      RAD= ABSRAD*1.1
      XAUTO(1)= XORIG-RAD
      XAUTO(2)= XORIG+RAD
      YSCALE= (Y2MAP0-Y1MAP0)/(X2MAP0-X1MAP0)
      YAUTO(1)= YORIG-RAD*YSCALE
      YAUTO(2)= YORIG+RAD*YSCALE
      CALL G0AUTO(XAUTO,YAUTO,1,2,1,2,1)
      XSAVE= XPLOT0
      YSAVE= YPLOT0
      CALL POSITN(XORIG,YORIG)
      XCPIE= XORIG
      YCPIE= YORIG
      NPVALS= NSECS
      PIERAD= ABSRAD
      TOTAL= 0.0
      SECMIN= ABS(VALUES(1))
C
      DO 100 IADD= 1,NSECS
        ABSVAL= ABS(VALUES(IADD))
        TOTAL= TOTAL+ABSVAL
        IF (SECMIN.GT.ABSVAL) SECMIN= ABSVAL
        IF (IADD.GT.50) GO TO 100
C
        PIEVAL(IADD)= VALUES(IADD)
  100 CONTINUE
C
      PIETOT= 2.0*PI/TOTAL
      SIZLIM= 0.72*SQRT(SECMIN/TOTAL)
C
C          FIND THE ANGLE OF EACH SECTOR THEN DRAW IT.
C          <OFFSET> IS NON-ZERO WHEN THE SECTOR IS SHIFTED-OUT.
C
      KOLSAV= KOLFL0
      KOLFL0= 0
      KOLIND= 1
      ADANGL= ANGPIE
C
      DO 200 N= 1,NSECS
        IF (LENLST.LE.0) GO TO 1
C
        KOLFL0= LSTCL0(KOLIND)
        KOLIND= KOLIND+1
        IF (KOLIND.GT.LENLST) KOLIND= 1
C
    1   ANGLE= ABS(VALUES(N))*PIETOT
        OFFSET= 0.0
        IF (VALUES(N).LT.0.0) OFFSET= 0.1
C
        RAD= ABSRAD*OFFSET
        ANGLAB= ANGLE*0.5+ADANGL
        RX= RAD*COS(ANGLAB)+XORIG
        RY= RAD*YSCALE*SIN(ANGLAB)+YORIG
        CALL POSITN(RX,RY)
        SX= ABSRAD*COS(ADANGL)+RX
        SY= ABSRAD*YSCALE*SIN(ADANGL)+RY
        CALL SECCIR(SX,SY,ANGLE/ANGCON)
        ADANGL= ADANGL+ANGLE
  200 CONTINUE
C
      CALL POSITN(XSAVE,YSAVE)
      KOLFL0= KOLSAV
      IPRINT= IPRSAV
C
      RETURN
      END
