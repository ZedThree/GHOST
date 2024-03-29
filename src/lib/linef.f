      SUBROUTINE LINEF(FUNCX,FUNCY,STRVAL,STEP,ENDVAL)
C
C          ------------------------------------------------
C          ROUTINE NO. (  99)   VERSION (A8.3)    04:MAR:91
C          ------------------------------------------------
C
C          THIS DRAWS A CURVE DEFINED BY THE TWO SUPPLIED FUNCTIONS.
C
C
C          THE ARGUMENTS ARE AS FOLLOWS:
C
C          <FUNCX>  IS THE DEFINING X-FUNCTION, AND
C          <FUNCY>  IS THE DEFINING Y-FUNCTION
C                   OF THE (IMPLICIT) CURVE PARAMETER,
C          <STRVAL> IS THE START VALUE,
C          <STEP>   IS THE INCREMENT SIZE, AND
C          <ENDVAL> IS THE END VALUE OF THE PARAMETER.
C
C
      REAL CURVEX(100),CURVEY(100)
C
      EXTERNAL FUNCX,FUNCY
C
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAR/ RTRAC1,RTRAC2,RTRAC3,RTRAC4
      COMMON /T3LIMS/ IMAXI,RMAXI,RMINI
C
      DATA IARRSZ /100/
C
C
      RTRAC1= STRVAL
      RTRAC2= STEP
      RTRAC3= ENDVAL
      IF (IPRINT.EQ.1) CALL G0MESG(41,3)
      IF (ABS(ENDVAL-STRVAL).LT.RMINI.OR.
     &    ABS(STEP).LT.RMINI) RETURN
C
      VALMIN= AMIN1(STRVAL,ENDVAL)
      VALMAX= AMAX1(STRVAL,ENDVAL)
      ABSTEP= ABS(STEP)
      NTOTAL= (VALMAX-VALMIN)/ABSTEP+0.99
      NREPS= (NTOTAL-1)/(IARRSZ-1)+1
      NSTEPS= (NTOTAL-1)/NREPS+2
      NFINIS= NTOTAL-(NSTEPS-1)*(NREPS-1)
      CURVEX(NSTEPS)= FUNCX(VALMIN)
      CURVEY(NSTEPS)= FUNCY(VALMIN)
      IPOS= 0
C
      DO 100 IREP= 1,NREPS
        CURVEX(1)= CURVEX(NSTEPS)
        CURVEY(1)= CURVEY(NSTEPS)
        IF (IREP.EQ.NREPS) NSTEPS= NFINIS
C
        DO 200 ISTEP= 2,NSTEPS
          IPOS= IPOS+1
          CPARAM= VALMIN+(ABSTEP*IPOS)
          CURVEX(ISTEP)= FUNCX(CPARAM)
          CURVEY(ISTEP)= FUNCY(CPARAM)
  200   CONTINUE
C
        IF (IREP.LT.NREPS) GO TO 1
C
        NSTEPS= NSTEPS+1
        CURVEX(NSTEPS)= FUNCX(VALMAX)
        CURVEY(NSTEPS)= FUNCY(VALMAX)
    1   CALL G0CURV(CURVEX,CURVEY,1,NSTEPS,0)
  100 CONTINUE
C
      RETURN
      END
