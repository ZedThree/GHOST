      SUBROUTINE G0SHAD(XPOS,YPOS,INDST,INDEND,XADDPT,YADDPT,INDADD,
     &                  SXPT,SYPT,SZPT)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 362)   VERSION (A9.1)    05:MAY:92
C          ------------------------------------------------
C
C          THIS ROUTINE CALCULATES THE REFLECTIVITY OF
C          A SHADED POLYGON.
C
      REAL    XPOS(*),YPOS(*),XADDPT(*),YADDPT(*),SXPT(4),SYPT(4),
     &        SZPT(4),ACOEFF(4),BCOEFF(4),CCOEFF(4),RDATA(1)
      INTEGER IDATA(1)
C
      COMMON /T0SKOL/ HUESHD,JKOLS,KOLSTA
      COMMON /T0SLIT/ ALIGHT,BLIGHT,CLIGHT
      COMMON /T0SREF/ AMBINT,DIFFUS,SPECT
C
      DATA RDATA /0.0/
C
C
C          CALCULATE THE NORMAL TO THE FACET BY AVERAGING
C          THE NORMALS OF THE FOUR TRIANGLES THAT CAN BE
C          FORMED FROM THE FOUR LINES OF THE FACET.
C
      DO 100 I= 1,4
        J= MOD(I,4)+1
        K= MOD(J,4)+1
        ACOEFF(I)= SYPT(I)*(SZPT(J)-SZPT(K))+
     &             SYPT(J)*(SZPT(K)-SZPT(I))+
     &             SYPT(K)*(SZPT(I)-SZPT(J))
        BCOEFF(I)= SZPT(I)*(SXPT(J)-SXPT(K))+
     &             SZPT(J)*(SXPT(K)-SXPT(I))+
     &             SZPT(K)*(SXPT(I)-SXPT(J))
        CCOEFF(I)= SXPT(I)*(SYPT(J)-SYPT(K))+
     &             SXPT(J)*(SYPT(K)-SYPT(I))+
     &             SXPT(K)*(SYPT(I)-SYPT(J))
C
C          NORMALISE THE COEFFICIENTS.
C
        SQR= SQRT(ACOEFF(I)*ACOEFF(I)+
     &            BCOEFF(I)*BCOEFF(I)+
     &            CCOEFF(I)*CCOEFF(I))
        ACOEFF(I)= ACOEFF(I)/SQR
        BCOEFF(I)= BCOEFF(I)/SQR
        CCOEFF(I)= CCOEFF(I)/SQR
  100 CONTINUE
C
C          AVERAGE THE NORMALS.
C
      ACOEFN= (ACOEFF(1)+ACOEFF(2)+ACOEFF(3)+ACOEFF(4))*0.25
      BCOEFN= (BCOEFF(1)+BCOEFF(2)+BCOEFF(3)+BCOEFF(4))*0.25
      CCOEFN= (CCOEFF(1)+CCOEFF(2)+CCOEFF(3)+CCOEFF(4))*0.25
C
C          NORMALISE THE COEFFICIENTS.
C
      SQR= SQRT(ACOEFN*ACOEFN+BCOEFN*BCOEFN+CCOEFN*CCOEFN)
      ACOEFN= ACOEFN/SQR
      BCOEFN= BCOEFN/SQR
      CCOEFN= CCOEFN/SQR
C
C          CALCULATE THE DOT PRODUCT BETWEEN THE
C          NORMAL AND THE LIGHT VECTOR.
C
      PRODNL= ACOEFN*ALIGHT+BCOEFN*BLIGHT+CCOEFN*CLIGHT
C
C          ADD THE AMBIENT LIGHT TO THE DIFFUSE LIGHT.
C
      PRODIF= AMBINT+DIFFUS*MIN(MAX(PRODNL,0.0),1.0)
C
C          CALCULATE THE SPECTURALLY REFLECTED LIGHT.
C
C          LET N BE THE NORMAL TO THE FACET.
C          LET E BE THE VECTOR TO THE VIEWER, (0,0,-1.0).
C          LET L BE THE LIGHT VECTOR.
C          LET H BE THE VECTOR THAT IS THE MEAN OF E AND L.
C          LET R BE THE REFLECTED VECTOR FROM THE FACET.
C          LET a BE THE ANGLE BETWEEN N AND H.
C          LET b BE THE ANGLE BETWEEN L AND H.
C          THIS IS ALSO THE ANGLE BETWEEN E AND H.
C          FROM GEOMETRY 2a IS THE ANGLE BETWEEN E AND R.
C
C          THEN
C
C          E.N= cos(b-a)
C          L.N= cos(b+a)
C          E.L= cos(2.0*b)= 2.0*cos(b)*cos(b)-1.0
C          THEREFORE cos(b)= sqrt((E.L)+1.0)/2.0)
C
C          NOW cos(b-a)= cos(a)*cos(b)-sin(a)*sin(b)
C          AND cos(b+a)= cos(a)*cos(b)+sin(a)*sin(b)
C          THEREFORE 2.0*cos(a)*cos(b)= cos(b-a)+cos(b+a)
C                                     = E.N+L.N
C          cos(a)= (E.N+L.N)/sqrt(2.0*(E.L+1.0))
C          cos(2.0*a)= (E.N+L.N)*(E.N+L.N)/(E.L+1.0)-1.0
C
      IF (PRODNL.GT.0.0) THEN
        IF (CLIGHT.LT.0.999) THEN
          COS2AL= (PRODNL-CCOEFN)*(PRODNL-CCOEFN)/(1.0-CLIGHT)-1.0
        ELSE
          COS2AL= 1.0
        ENDIF
C
        COS2AL= MIN(MAX(COS2AL,0.0),1.0)
        PRODSP= SPECT*COS2AL**3
      ELSE
        PRODSP= 0.0
      ENDIF
C
C          ADD IN THE SPECTURALLY REFLECTED LIGHT.
C
      PROD= PRODIF+PRODSP
      PROD= MIN(MAX(PROD,0.0),1.0)
      IDATA(1)= 0
      CALL G3LINK(5,13,-1,IDATA,RDATA)
      IDATA(1)= NINT(PROD*JKOLS)+KOLSTA
      CALL G3LINK(5,3,-1,IDATA,RDATA)
      IPFLAG= 0
      IF (INDST.LE.INDEND) THEN
        XSAV= XPOS(INDST)
        YSAV= YPOS(INDST)
        CALL POSITN(XSAV,YSAV)
        IPFLAG= 1
        IF (INDST.LT.INDEND) THEN
C
          DO 200 IND= INDST+1,INDEND
            CALL JOIN(XPOS(IND),YPOS(IND))
  200     CONTINUE
C
        ENDIF
      ENDIF
C
      IF (INDADD.GT.0) THEN
        INDLST= INDADD
        IF (IPFLAG.EQ.0) THEN
          XSAV= XADDPT(INDADD)
          YSAV= YADDPT(INDADD)
          CALL POSITN(XSAV,YSAV)
          INDLST= INDADD-1
        ENDIF
C
        IF (INDLST.GT.0) THEN
C
          DO 300 IND= INDLST,1,-1
            CALL JOIN(XADDPT(IND),YADDPT(IND))
  300     CONTINUE
C
        ENDIF
      ENDIF
C
      CALL JOIN(XSAV,YSAV)
      CALL G3LINK(5,4,0,IDATA,RDATA)
C
      RETURN
      END
