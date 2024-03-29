      SUBROUTINE SURLIT(XLIGHT,YLIGHT,ZLIGHT)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 346)   VERSION (A9.1)    05:MAY:92
C          ------------------------------------------------
C
C          THIS SPECIFIES THE DIRECTION OF THE LIGHT
C          SOURCE FOR SHADED SURFACES.
C
C
C          THE ARGUMENTS ARE AS FOLLOWS:
C
C          <XLIGHT>  THE X COORDINATE OF THE LIGHT SOURCE.
C          <YLIGHT>  THE Y COORDINATE OF THE LIGHT SOURCE.
C          <ZLIGHT>  THE Z COORDINATE OF THE LIGHT SOURCE.
C
C
      COMMON /T0SLIT/ ALIGHT,BLIGHT,CLIGHT
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAR/ RTRAC1,RTRAC2,RTRAC3,RTRAC4
C
C
      CALL G3INIT(2)
C
      RTRAC1= XLIGHT
      RTRAC2= YLIGHT
      RTRAC3= ZLIGHT
      IF (IPRINT.EQ.1) CALL G0MESG(194,3)
C
C          NORMALISE THE VECTOR.
C
      SQR= SQRT(XLIGHT*XLIGHT+YLIGHT*YLIGHT+ZLIGHT*ZLIGHT)
      ALIGHT= XLIGHT/SQR
      BLIGHT= YLIGHT/SQR
      CLIGHT= ZLIGHT/SQR
      RETURN
      END
