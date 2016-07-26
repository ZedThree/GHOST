      SUBROUTINE G1CHSP
C
C          ------------------------------------------------
C          ROUTINE NO. (1034)   VERSION (A8.1)    14:JUL:97
C          ------------------------------------------------
C
C          THIS SUPPORTS G1CLS2 AND RESETS THE CHARACTER SPACING CONSTANTS.
C
C
      LOGICAL TYPMOD
C
      COMMON /T1CANG/ STANG1,CRANG1
      COMMON /T1CANU/ STANGU,CRANGU
      COMMON /T1CDCS/ SINSTR,COSSTR
      COMMON /T1CDIM/ MAGN1,OBLAT1
      COMMON /T1CMOC/ ADDSPX,ADDLNX,ADDSPY,ADDLNY
      COMMON /T1CMOD/ TYPMOD
      COMMON /T1CMOV/ ADDSP,ADDLN
      COMMON /T1CSPA/ X1CHR1,X2CHR1,Y1CHR1,Y2CHR1
      COMMON /T1TSPA/ X1TYPW,X2TYPW,Y1TYPW,Y2TYPW
      COMMON /T1TYPQ/ IQUAD
      COMMON /T3CONS/ PI
C
C
C          THE FOLLOWING IS A STATEMENT FUNCTION TO CONVERT AN
C          ANGLE (RADIANS) INTO A QUADRANT NO.
C
      KQUADR(STANG1)= (STANG1*2.0/PI)+0.5
C
      ADDLN= MAGN1*1.428571E-3
      SINANG= ABS(SIN(CRANGU-STANGU))
      COSANG= ABS(COS(CRANGU-STANGU))
      IF (ADDSP*SINANG.GT.ADDLN*COSANG) THEN
        SAVE= ADDSP
        ADDSP= ADDLN/SINANG
        ADDLN= SAVE/SINANG
      ELSE
        ADDSP= ADDSP/COSANG
        ADDLN= ADDLN/COSANG
      ENDIF
C
      ADDSPX=  ADDSP*COSSTR
      ADDSPY=  ADDSP*SINSTR
      ADDLNX=  ADDLN*SINSTR
      ADDLNY= -ADDLN*COSSTR
C
C          IF TYPING MODE IS IN EFFECT, THE TYPING MODE WINDOW
C          IS SET. THIS IS SMALLER THAN THE CHARACTER WINDOW IN
C          EACH DIRECTION BY THE APPROPRIATE (CHARACTER OR LINE)
C          SPACING TO AVOID PARTIAL WINDOWING OF EDGE CHARACTERS.
C
      IF (.NOT.TYPMOD) RETURN
C
      IQUAD= MOD(KQUADR(STANG1),4)+1
      IF (IQUAD.EQ.1.OR.IQUAD.EQ.3) THEN
        ASP= ADDSP
        ALN= ADDLN
      ELSE
        ASP= ADDLN
        ALN= ADDSP
      ENDIF
C
      X1TYPW= X1CHR1+0.7*ASP
      X2TYPW= X2CHR1-0.7*ASP
      Y1TYPW= Y1CHR1+0.7*ALN
      Y2TYPW= Y2CHR1-0.7*ALN
C
      RETURN
C
      END