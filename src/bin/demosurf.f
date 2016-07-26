C                       SURFACE DRAWING DEMO PROGRAM
C
C                                OF GHOST-80.
C
C
      INTEGER KOLS(12)
C
      COMMON /CHOI/ ICHOIC,ISECS
      COMMON /DEMOAA/ SURFAS(51,51),CLEVLS(51),ICLARR(50,50),
     &                SURFA1(101,101),SURFA2(201,201)
C
      DATA LIMIT1 /201/
      DATA RCEN1 /101.1/, SFACT1 /0.0125/
C
    1 WRITE (6,*) 'CHOOSE COUNTRY :'
      WRITE (6,*) '       1 : UNITED KINGDOM'
      WRITE (6,*) '       2 : SCOTLAND'
      WRITE (6,*)
      WRITE (6,*) 'ENTER YOUR CHOICE (1 OR 2)'
      READ (5,*) ICNTRY
      IF (ICNTRY.LT.1.OR.ICNTRY.GT.2) GO TO 1
C
    2 WRITE (6,*) 'CHOOSE NUMBER OF BIT PLANES :'
      WRITE (6,*) '       1 : 4 BIT PLANES (16 COLOURS)'
      WRITE (6,*) '       2 : 8 BIT PLANES (256 COLOURS)'
      WRITE (6,*)
      WRITE (6,*) 'ENTER YOUR CHOICE (1 OR 2)'
      READ (5,*) NPLANE
      IF (NPLANE.LT.1.OR.NPLANE.GT.2) GO TO 2
C
    3 WRITE (6,*) 'CHOOSE AS FOLLOWS :'
      WRITE (6,*) '       1 : AUTOMATIC DISPLAY'
      WRITE (6,*) '       2 : STEPPED THROUGH DISPLAY'
      WRITE (6,*)
      WRITE (6,*) 'ENTER YOUR CHOICE (1 OR 2)'
      READ (5,*) ICHOIC
      IF (ICHOIC.LT.1.OR.ICHOIC.GT.2) GO TO 3
      IF (ICHOIC.EQ.1) THEN
    4   WRITE (6,*) 'ENTER :'
        WRITE (6,*) '    0 FOR INFINITE DISPLAYS OR'
        WRITE (6,*) '    n FOR NUMBER OF DISPLAYS'
        WRITE (6,*) 'ENTER YOUR CHOICE (0,1 OR 2)'
        READ  (5,*) ICHOI2
        IF (ICHOI2.LT.0) GO TO 4
C
        WRITE (6,*) 'ENTER DELAY IN SECONDS BETWEEN PICTURES'
        READ  (5,*) IDELAY
        ISECS= IDELAY
      ENDIF
C
      PI= 3.14159
      BETA= 1.0
    5 CALL PAPER(1)
      CALL GPSTOP(99)
C
      DO 100 J= 1,LIMIT1
        RJJ= (J-RCEN1)*SFACT1
C
        DO 100 I= 1,LIMIT1
          RII= (I-RCEN1)*SFACT1
          ALPHA= 0.75*RJJ*(3.0*RII*RII-RJJ*RJJ)
          SURFA2(I,J)= ALPHA+BETA*COS(6.0*PI*SQRT(RII*RII+RJJ*RJJ)+
     &                   ATAN2(RII,RJJ))
          IF (MOD(I,2).EQ.1.AND.MOD(J,2).EQ.1)THEN
            II= I/2+1
            JJ= J/2+1
            SURFA1(II,JJ)= SURFA2(I,J)
            IF (MOD(II,2).EQ.1.AND.MOD(JJ,2).EQ.1)THEN
              III= II/2+1
              JJJ= JJ/2+1
              SURFAS(III,JJJ)= SURFA1(II,JJ)
              IF (III.EQ.1.OR.JJJ.EQ.1) GO TO 100
C
              HEIGHT= (SURFAS(III-1,JJJ-1)+SURFAS(III,JJJ-1)+
     &                 SURFAS(III-1,JJJ)+SURFAS(III,JJJ))*0.25
              KKOL= NINT((HEIGHT+5.895)*1.6)
              IF (KKOL.EQ.5) THEN
                KKOL= 15
              ELSE
                IF (KKOL.EQ.15) KKOL= 5
              ENDIF
C
              ICLARR(III-1,JJJ-1)= KKOL
            ENDIF
C
          ENDIF
C
  100 CONTINUE
C
      CALL MATCOL(ICLARR,50,50)
C
      DO 200 I=1,11
        CLEVLS(I)= (I-6)*0.61+0.01
  200 CONTINUE
C
      DO 300 I= 1,12
        KOLS(I)= I+3
  300 CONTINUE
C
      KOLS(2)= 15
      KOLS(12)= 5
      CALL LSTCOL(KOLS,12)
C
C          THIS PROGRAM WILL ASSUME THE FOLLOWING SETTINGS AT
C          THE START OF EACH SUBROUTINE.  ANY CHANGES MADE IN
C          A SUBROUTINE MUST BE RESET AT THE END.
C
C          BACCOL(0)
C          CTRANG(0.0)
C          CTRFNT(14)
C          CTRMAG(35)
C          CTRORI(0.0)
C          FILCOL(0)
C          LINCOL(0)
C          MAP(0.0,1.0,0.0,1.0)
C          PSPACE(0.15,1.15,0.0,1.0)
C          THICK(1)
C          WINDOW(0.0,1.0,0.0,1.0)
C
      CALL CTRFNT(14)
      CALL CTRMAG(35)
      CALL PSPACE(0.15,1.15,0.0,1.0)
      CALL OPNPIC
      CALL DELAY(1)
      CALL OPENT
      CALL DELAY(0)
      CALL SPIC1T
      CALL DELAY(0)
      CALL SPIC1
      CALL DELAY(1)
      CALL SPIC2T
      CALL DELAY(0)
      CALL SPIC2
      CALL DELAY(1)
      CALL SPIC3T
      CALL DELAY(0)
      CALL SPIC3
      CALL DELAY(1)
      CALL SPIC4T
      CALL DELAY(0)
      CALL SPIC4
      CALL DELAY(1)
      CALL RESCOL
      CALL SPIC5T
      CALL DELAY(0)
      CALL SPIC5
      CALL DELAY(1)
      CALL RESCOL
      CALL SPIC6T
      CALL DELAY(0)
      CALL SPIC6
      CALL DELAY(1)
      CALL RESCOL
      CALL SPIC7T
      CALL DELAY(0)
      CALL SPIC7
      CALL DELAY(1)
      CALL RESCOL
      CALL SPIC8T
      CALL DELAY(0)
      CALL SPIC8
      CALL DELAY(1)
      CALL RESCOL
      IF (NPLANE.EQ.2) THEN
        CALL SPIC9T
        CALL DELAY(0)
        CALL SPIC9
        CALL DELAY(1)
        CALL RESCOL
      ENDIF
C
      CALL SPI10T
      CALL DELAY(0)
      CALL SPIC10
      CALL DELAY(1)
      CALL RESCOL
      CALL SPI11T
      CALL DELAY(0)
      CALL SPIC11
      CALL DELAY(1)
      CALL RESCOL
      CALL SPI12T
      CALL DELAY(0)
      CALL SPIC12(NPLANE)
      CALL DELAY(1)
      CALL RESCOL
      CALL SPI13T
      CALL DELAY(0)
      IF (ICNTRY.EQ.1) CALL SPIC13
      IF (ICNTRY.EQ.2) CALL SPIC14
C
      CALL DELAY(1)
      CALL RESCOL
      CALL LASTPI
      CALL DELAY(1)
      CALL RESCOL
      IF (ICHOIC.EQ.2) GO TO 6
      IF (ICHOI2.EQ.0) GO TO 5
      ICHOI2= ICHOI2-1
      IF (ICHOI2.NE.0) GO TO 5
    6 CALL GREND
      STOP
      END
C
C=====================================================================
C
      SUBROUTINE CHINT(TIME,ITIME)
C
C     SUBROUTINE TO CHANGE CHARACTER TIME TO INTEGER TIME
C
      CHARACTER*8 TIME
C
      READ(TIME,10) IHRS,IMINS,ISECS
   10 FORMAT(I2,1X,I2,1X,I2)
      ITIME=3600*IHRS+60*IMINS+ISECS
C
      RETURN
      END
C
C=====================================================================
C
      SUBROUTINE DELAY(IPATN)
C
C     SUBROUTINE TO GIVE A REAL DELAY
C     OF ISECS BEFORE ERASING SCREEN
C     IF HOWEVER ICHOIC IS 2 PIC IS
C     FRAMED I.E. USER DEFINED DELAY.
C
      COMMON /CHOI/ ICHOIC,ISECS
C
      CHARACTER*8 TIME
C
      IF (ICHOIC.EQ.2) THEN
        CALL FRAME
        RETURN
      ENDIF
C
        CALL PICNOW
        CALL ENQTIM(TIME)
        CALL CHINT(TIME,ITIME)
        ISTOP=ITIME+ISECS
    1   CALL ENQTIM(TIME)
        CALL CHINT(TIME,ITIME)
        IF (ITIME.LT.ISTOP) GO TO 1
C
        IF (IPATN.GT.0) THEN
          CALL PSPACE(0.0,1.5,0.0,1.0)
          CALL FLLBND(0)
          CALL COLSET(0.0,0.0,0.0,1)
          CALL FILCOL(1)
          CALL LINCOL(1)
          NSTEPS= 240
          Y1= 0.0
          Y4= 1.0
          YINC= 0.5/NSTEPS
          Y2= YINC
          Y3= 1.0-YINC
          CALL BORDER
C
          DO 100 I= 1,NSTEPS
            CALL BOX(0.0,1.0,Y1,Y2)
            CALL BOX(0.0,1.0,Y3,Y4)
            Y1= Y2
            Y2= Y2+YINC
            Y4= Y3
            Y3= Y3-YINC
  100     CONTINUE
C
          CALL FILCOL(0)
          CALL LINCOL(0)
          CALL FLLBND(1)
          CALL PSPACE(0.15,1.15,0.0,1.0)
C
        ENDIF
C
        CALL ERASE
      RETURN
      END
C
C================================================================
C
      SUBROUTINE LASTPI
C
        CALL POSITN(0.5,0.5)
        CALL BACCOL(4)
        CALL LINCOL(0)
        CALL FILCOL(2)
        CALL THICK(1)
        CALL ELLPSE(0.5,0.4)
        CALL THICK(6)
        CALL CTRMAG(100)
        CALL LINCOL(8)
        CALL PCSCEN(0.5,0.6,'GHOST')
        CALL THICK(3)
        CALL CTRMAG(30)
        CALL LINCOL(3)
        CALL PCSCEN(0.5,0.4,'A software product from')
C        CALL CTRMAG(50)
        CALL LINCOL(6)
C        CALL THICK(5)
        CALL PCSCEN(0.5,0.2,'AEA Technology')
      CALL CTRMAG(35)
      CALL FILCOL(0)
      CALL LINCOL(0)
      CALL THICK(1)
C
      RETURN
      END
C
C========================================================================
C
      SUBROUTINE OPENT
C
        CALL LINCOL(6)
        CALL PCSCEN(0.5,0.8,'All of the pictures in this')
        CALL PCSCEN(0.5,0.65,'demonstration are being calculated')
        CALL PCSCEN(0.5,0.5,'as you watch.  Take account of the')
        CALL PCSCEN(0.5,0.35,'power of the computer being used.')
        CALL PCSCEN(0.5,0.2,'There are no precalculated pictures.')
      CALL LINCOL(0)
C
      RETURN
      END
C
C=====================================================================
C
      SUBROUTINE OPNPIC
C
        CALL POSITN(0.5,0.5)
        CALL ELLPSE(0.5,0.4)
        CALL THICK(4)
        CALL LINCOL(3)
        CALL CTRMAG(70)
        CALL CTRFNT(14)
        CALL PCSCEN(0.5,0.75,'WELCOME')
        CALL THICK(1)
        CALL LINCOL(6)
        CALL CTRMAG(30)
        CALL PCSCEN(0.5,0.63,'TO THE')
        CALL THICK(3)
        CALL LINCOL(2)
        CALL CTRMAG(70)
        CALL PLOTCS(0.13,0.5,'D')
        CALL LINCOL(0)
        CALL TYPECS('E')
        CALL LINCOL(4)
        CALL TYPECS('M')
        CALL LINCOL(6)
        CALL TYPECS('O')
        CALL LINCOL(2)
        CALL TYPECS('N')
        CALL LINCOL(7)
        CALL TYPECS('S')
        CALL LINCOL(8)
        CALL TYPECS('T')
        CALL LINCOL(3)
        CALL TYPECS('R')
        CALL LINCOL(4)
        CALL TYPECS('A')
        CALL LINCOL(7)
        CALL TYPECS('T')
        CALL LINCOL(6)
        CALL TYPECS('I')
        CALL LINCOL(0)
        CALL TYPECS('O')
        CALL LINCOL(8)
        CALL TYPECS('N')
        CALL THICK(1)
        CALL LINCOL(6)
        CALL CTRMAG(30)
        CALL PCSCEN(0.5,0.39,'OF')
        CALL LINCOL(8)
        CALL CTRMAG(85)
        CALL THICK(5)
        CALL PCSCEN(0.5,0.25,'GHOST')
      CALL CTRFNT(14)
      CALL CTRMAG(35)
      CALL LINCOL(0)
      CALL THICK (1)
C
      RETURN
      END
C
C=====================================================================
C
      SUBROUTINE RESCOL
C
C     SUBROUTINE TO RESET GHOST COLOURS 1-8.
C
      REAL COLINF(8,3)
C
      DATA COLINF /0.0  ,0.333,0.666,0.0  ,0.0  ,0.833,0.166,0.500,
     &             0.0  ,1.0  ,1.0  ,1.0  ,0.0  ,1.0  ,1.0  ,1.0  ,
     &             0.0  ,1.0  ,1.0  ,1.0  ,1.0  ,1.0  ,1.0  ,1.0/
C
        DO 100 I= 1,8
          CALL COLSET(COLINF(I,1),COLINF(I,2),COLINF(I,3),I)
  100   CONTINUE
C
      CALL BACCOL(0)
      RETURN
      END
C
C========================================================================
C
      SUBROUTINE SPIC1
C
      COMMON /DEMOAA/ SURFAS(51,51),CLEVLS(51),ICLARR(50,50),
     &                SURFA1(101,101),SURFA2(201,201)
C
        CALL LINCOL(3)
        CALL CTRFNT(15)
        CALL PCSEND(1.0,0.05,'GHOST')
        CALL PSPACE(0.01,1.29,0.1,1.0)
        CALL SURCOL(0,2,3)
        CALL SURROT(245.0)
        CALL SURANG(45.0)
        CALL SURBAS(1,1,0.0)
        CALL SURPLT(SURFAS,1,51,51,1,51,51)
      CALL LINCOL(0)
      CALL CTRFNT(14)
      CALL PSPACE(0.15,1.15,0.0,1.0)
      RETURN
      END
C
C========================================================================
C
      SUBROUTINE SPIC2
C
      COMMON /DEMOAA/ SURFAS(51,51),CLEVLS(51),ICLARR(50,50),
     &                SURFA1(101,101),SURFA2(201,201)
C
        CALL LINCOL(3)
        CALL CTRFNT(15)
        CALL PCSEND(1.0,0.05,'GHOST')
        CALL LINCOL(0)
        CALL CTRFNT(11)
        CALL CTRMAG(15)
        CALL PSPACE(0.01,0.62,0.58,1.0)
        CALL SURCOL(8,2,3)
        CALL SURROT(20.0)
        CALL SURANG(75.0)
        CALL SURBAS(1,1,0.0)
        CALL SURPLT(SURFAS,1,51,51,1,51,51)
        CALL PCSCEN(0.5,-0.1,'AZ = 20   EL= 75')
        CALL PSPACE(0.68,1.29,0.58,1.0)
        CALL SURCOL(0,3,2)
        CALL SURROT(80.0)
        CALL SURANG(45.0)
        CALL SURBAS(1,1,0.0)
        CALL SURPLT(SURFAS,1,51,51,1,51,51)
        CALL PCSCEN(0.5,-0.1,'AZ = 80   EL= 45')
        CALL PSPACE(0.01,0.62,0.1,0.52)
        CALL SURCOL(6,4,3)
        CALL SURROT(150.0)
        CALL SURANG(15.0)
        CALL SURBAS(1,1,0.0)
        CALL SURPLT(SURFAS,1,51,51,1,51,51)
        CALL PCSCEN(0.5,-0.1,'AZ = 150   EL= 15')
        CALL PSPACE(0.68,1.29,0.1,0.52)
        CALL SURCOL(7,2,3)
        CALL SURROT(220.0)
        CALL SURANG(-15.0)
        CALL SURBAS(1,1,0.0)
        CALL SURPLT(SURFAS,1,51,51,1,51,51)
        CALL PCSCEN(0.55,0.1,'AZ = 220     EL= -15')
      CALL CTRFNT(14)
      CALL PSPACE(0.15,1.15,0.0,1.0)
      CALL CTRMAG(35)
      RETURN
      END
C
C========================================================================
C
      SUBROUTINE SPIC3
C
      COMMON /DEMOAA/ SURFAS(51,51),CLEVLS(51),ICLARR(50,50),
     &                SURFA1(101,101),SURFA2(201,201)
C
        CALL LINCOL(3)
        CALL CTRFNT(15)
        CALL PCSEND(1.0,0.05,'GHOST')
        CALL CTRFNT(1)
        CALL PSPACE(0.05,1.25,0.1,1.0)
        CALL SURCOL(0,2,3)
        CALL SURROT(-55.0)
        CALL SURANG(35.0)
        CALL SURBAS(1,1,0.0)
        CALL SURAXE(1,0.0,0.0,0.0,0.0)
        CALL SURPLT(SURFAS,1,51,51,1,51,51)
        CALL SURAXE(0,0.0,0.0,0.0,0.0)
      CALL LINCOL(0)
      CALL CTRFNT(14)
      CALL PSPACE(0.15,1.15,0.0,1.0)
      RETURN
      END
C
C========================================================================
C
      SUBROUTINE SPIC4
C
      COMMON /DEMOAA/ SURFAS(51,51),CLEVLS(51),ICLARR(50,50),
     &                SURFA1(101,101),SURFA2(201,201)
C
        CALL RGB
        CALL COLSET(0.0,0.4,0.2,4)
        CALL COLSET(0.0,1.0,0.0,6)
        CALL COLSET(1.0,1.0,0.0,7)
        CALL COLSET(1.0,0.8,0.0,8)
        CALL COLSET(1.0,0.6,0.0,9)
        CALL COLSET(1.0,0.4,0.2,10)
        CALL COLSET(0.6,0.4,0.2,11)
        CALL COLSET(0.6,0.2,0.4,12)
        CALL COLSET(0.8,0.2,0.6,13)
        CALL COLSET(0.6,0.6,1.0,14)
        CALL COLSET(0.0,0.6,0.2,15)
        CALL HSV
        CALL LINCOL(3)
        CALL CTRFNT(15)
        CALL PCSEND(1.0,0.05,'GHOST')
        CALL CTRFNT(1)
        CALL PSPACE(0.05,1.25,0.1,1.0)
        CALL SURCOL(0,0,4)
        CALL SURROT(-25.0)
        CALL SURANG(60.0)
        CALL SURBAS(0,1,0.0)
        CALL SURCL4(SURFAS,1,51,51,1,51,51)
      CALL LINCOL(0)
      CALL CTRFNT(14)
      CALL PSPACE(0.15,1.15,0.0,1.0)
      RETURN
      END
C
C========================================================================
C
      SUBROUTINE SPIC5
C
      COMMON /DEMOAA/ SURFAS(51,51),CLEVLS(51),ICLARR(50,50),
     &                SURFA1(101,101),SURFA2(201,201)
C
        CALL RGB
        CALL COLSET(0.0,0.4,0.2,4)
        CALL COLSET(0.0,1.0,0.0,6)
        CALL COLSET(1.0,1.0,0.0,7)
        CALL COLSET(1.0,0.8,0.0,8)
        CALL COLSET(1.0,0.6,0.0,9)
        CALL COLSET(1.0,0.4,0.2,10)
        CALL COLSET(0.6,0.4,0.2,11)
        CALL COLSET(0.6,0.2,0.4,12)
        CALL COLSET(0.8,0.2,0.6,13)
        CALL COLSET(0.6,0.6,1.0,14)
        CALL COLSET(0.0,0.6,0.2,15)
        CALL HSV
        CALL LINCOL(3)
        CALL CTRFNT(15)
        CALL PCSEND(1.0,0.05,'GHOST')
        CALL CTRFNT(1)
        CALL PSPACE(0.05,1.25,0.1,1.0)
        CALL SURCOL(0,0,4)
        CALL SURROT(-25.0)
        CALL SURANG(60.0)
        CALL SURBAS(0,1,0.0)
        CALL SURCL4(SURFAS,1,51,51,1,51,51)
        CALL SURBAS(0,0,0.0)
        CALL SURPLT(SURFAS,1,51,51,1,51,51)
      CALL LINCOL(0)
      CALL CTRFNT(14)
      CALL PSPACE(0.15,1.15,0.0,1.0)
      RETURN
      END
C
C========================================================================
C
      SUBROUTINE SPIC6
C
      COMMON /DEMOAA/ SURFAS(51,51),CLEVLS(51),ICLARR(50,50),
     &                SURFA1(101,101),SURFA2(201,201)
C
        CALL RGB
        CALL COLSET(0.0,0.4,0.2,4)
        CALL COLSET(0.0,1.0,0.0,6)
        CALL COLSET(1.0,1.0,0.0,7)
        CALL COLSET(1.0,0.8,0.0,8)
        CALL COLSET(1.0,0.6,0.0,9)
        CALL COLSET(1.0,0.4,0.2,10)
        CALL COLSET(0.6,0.4,0.2,11)
        CALL COLSET(0.6,0.2,0.4,12)
        CALL COLSET(0.8,0.2,0.6,13)
        CALL COLSET(0.6,0.6,1.0,14)
        CALL COLSET(0.0,0.6,0.2,15)
        CALL HSV
        CALL LINCOL(3)
        CALL CTRFNT(15)
        CALL PCSEND(1.0,0.05,'GHOST')
        CALL CTRFNT(1)
        CALL PSPACE(0.05,1.25,0.1,1.0)
        CALL SURCOL(0,0,4)
        CALL SURROT(15.0)
        CALL SURANG(70.0)
        CALL SURBAS(0,1,0.0)
        CALL SURFLC(SURFA1,1,101,101,1,101,101,CLEVLS,1,11)
      CALL LINCOL(0)
      CALL CTRFNT(14)
      CALL PSPACE(0.15,1.15,0.0,1.0)
      RETURN
      END
C
C========================================================================
C
      SUBROUTINE SPIC7
C
      COMMON /DEMOAA/ SURFAS(51,51),CLEVLS(51),ICLARR(50,50),
     &                SURFA1(101,101),SURFA2(201,201)
C
        CALL RGB
        CALL COLSET(0.0,0.4,0.2,4)
        CALL COLSET(0.0,1.0,0.0,6)
        CALL COLSET(1.0,1.0,0.0,7)
        CALL COLSET(1.0,0.8,0.0,8)
        CALL COLSET(1.0,0.6,0.0,9)
        CALL COLSET(1.0,0.4,0.2,10)
        CALL COLSET(0.6,0.4,0.2,11)
        CALL COLSET(0.6,0.2,0.4,12)
        CALL COLSET(0.8,0.2,0.6,13)
        CALL COLSET(0.6,0.6,1.0,14)
        CALL COLSET(0.0,0.6,0.2,15)
        CALL HSV
        CALL LINCOL(3)
        CALL CTRFNT(15)
        CALL PCSEND(1.0,0.05,'GHOST')
        CALL CTRFNT(1)
        CALL PSPACE(0.05,1.25,0.1,1.0)
        CALL SURCOL(0,0,4)
        CALL SURROT(-65.0)
        CALL SURANG(70.0)
        CALL SURBAS(0,1,0.0)
        CALL SURCON(1)
        CALL SURFLC(SURFA1,1,101,101,1,101,101,CLEVLS,1,11)
        CALL SURAXE(1,0.0,0.0,0.0,0.0)
        CALL SURPLT(SURFAS,1,51,51,1,51,51)
        CALL SURAXE(0,0.0,0.0,0.0,0.0)
      CALL LINCOL(0)
      CALL CTRFNT(14)
      CALL PSPACE(0.15,1.15,0.0,1.0)
      RETURN
      END
C
C========================================================================
C
      SUBROUTINE SPIC8
C
      COMMON /DEMOAA/ SURFAS(51,51),CLEVLS(51),ICLARR(50,50),
     &                SURFA1(101,101),SURFA2(201,201)
C
C
        CALL RGB
        CALL COLSET(0.0,0.4,0.2,4)
        CALL COLSET(0.0,1.0,0.0,6)
        CALL COLSET(1.0,1.0,0.0,7)
        CALL COLSET(1.0,0.8,0.0,8)
        CALL COLSET(1.0,0.6,0.0,9)
        CALL COLSET(1.0,0.4,0.2,10)
        CALL COLSET(0.6,0.4,0.2,11)
        CALL COLSET(0.6,0.2,0.4,12)
        CALL COLSET(0.8,0.2,0.6,13)
        CALL COLSET(0.6,0.6,1.0,14)
        CALL COLSET(0.0,0.6,0.2,15)
        CALL HSV
        CALL LINCOL(3)
        CALL CTRFNT(15)
        CALL PCSEND(1.0,0.85,'GHOST')
        CALL CTRFNT(1)
        CALL PSPACE(0.1,1.2,0.1,0.95)
        CALL SURCOL(0,0,4)
        CALL SURCON(1)
        CALL SURAXE(1,0.0,0.0,0.0,0.0)
        CALL SURCUT(SURFA1,1,101,101,98,5,101,CLEVLS,1,11)
        CALL SURAXE(0,0.0,0.0,0.0,0.0)
      CALL LINCOL(0)
      CALL CTRFNT(14)
      CALL PSPACE(0.15,1.15,0.0,1.0)
      RETURN
      END
C
C========================================================================
C
      SUBROUTINE SPIC9
C
      COMMON /DEMOAA/ SURFAS(51,51),CLEVLS(51),ICLARR(50,50),
     &                SURFA1(101,101),SURFA2(201,201)
C
      INTEGER KOLS(52)
C
C
        DO 100 I=1,51
          CLEVLS(I)= (I-26)*0.13+0.01
  100   CONTINUE
C
        DO 200 I= 1,52
          KOLS(I)= I+24
  200   CONTINUE
C
        CALL LSTCOL(KOLS,52)
        CALL HLS
C
	DO 300 I= 1,52
          CLR= 0.2+I*0.015
          CALL COLSET(0.4,CLR,1.0,I+24)
  300   CONTINUE
C
        CALL LINCOL(3)
        CALL CTRFNT(15)
        CALL PCSEND(1.0,0.05,'GHOST')
        CALL CTRFNT(1)
        CALL PSPACE(0.05,1.25,0.1,1.0)
        CALL SURCOL(0,0,44)
        CALL SURROT(-65.0)
        CALL SURCON(0)
        CALL SURANG(70.0)
        CALL SURBAS(0,1,0.0)
        CALL SURFLC(SURFA1,1,101,101,1,101,101,CLEVLS,1,51)
C
      DO 400 I=1,11
        CLEVLS(I)= (I-6)*0.61+0.01
  400 CONTINUE
C
      DO 500 I= 1,12
        KOLS(I)= I+3
  500 CONTINUE
C
      KOLS(2)= 15
      KOLS(12)= 5
      CALL LSTCOL(KOLS,12)
      CALL HSV
      CALL LINCOL(0)
      CALL CTRFNT(14)
      CALL PSPACE(0.15,1.15,0.0,1.0)
      RETURN
      END
C
C========================================================================
C
      SUBROUTINE SPIC10
C
      COMMON /DEMOAA/ SURFAS(51,51),CLEVLS(51),ICLARR(50,50),
     &                SURFA1(101,101),SURFA2(201,201)
C
        CALL RGB
        CALL COLSET(0.0,0.4,0.2,4)
        CALL COLSET(0.0,1.0,0.0,6)
        CALL COLSET(1.0,1.0,0.0,7)
        CALL COLSET(1.0,0.8,0.0,8)
        CALL COLSET(1.0,0.6,0.0,9)
        CALL COLSET(1.0,0.4,0.2,10)
        CALL COLSET(0.6,0.4,0.2,11)
        CALL COLSET(0.6,0.2,0.4,12)
        CALL COLSET(0.8,0.2,0.6,13)
        CALL COLSET(0.6,0.6,1.0,14)
        CALL COLSET(0.0,0.6,0.2,15)
        CALL HSV
        CALL LINCOL(3)
        CALL CTRFNT(15)
        CALL PCSEND(1.0,0.05,'GHOST')
        CALL CTRFNT(1)
        CALL PSPACE(0.01,0.62,0.58,1.0)
        CALL SURCOL(8,2,3)
        CALL SURIND(0)
        CALL SURROT(-205.0)
        CALL SURANG(-20.0)
        CALL SURBAS(1,0,0.0)
        CALL SURPLT(SURFAS,1,51,51,1,51,51)
        CALL PSPACE(0.68,1.29,0.58,1.0)
        CALL SURCOL(0,0,4)
        CALL SURROT(62.0)
        CALL SURANG(90.0)
        CALL SURBAS(0,0,0.0)
        CALL SURCON(1)
        CALL SURFLC(SURFAS,1,51,51,1,51,51,CLEVLS,1,11)
        CALL PSPACE(0.19,1.11,0.01,0.64)
        CALL SURROT(55.0)
        CALL SURANG(55.0)
        CALL SURBAS(0,1,0.0)
        CALL SURCON(0)
        CALL SURFLC(SURFA1,1,101,101,1,101,101,CLEVLS,1,11)
        CALL SURAXE(1,0.0,0.0,0.0,0.0)
        CALL SURPLT(SURFAS,1,51,51,1,51,51)
      CALL LINCOL(0)
      CALL CTRFNT(14)
      CALL PSPACE(0.15,1.15,0.0,1.0)
      RETURN
      END
C
C========================================================================
C
      SUBROUTINE SPIC11
C
      COMMON /DEMOAA/ SURFAS(51,51),CLEVLS(51),ICLARR(50,50),
     &                SURFA1(101,101),SURFA2(201,201)
C
        CALL RGB
        CALL COLSET(0.0,0.4,0.2,4)
        CALL COLSET(0.0,1.0,0.0,6)
        CALL COLSET(1.0,1.0,0.0,7)
        CALL COLSET(1.0,0.8,0.0,8)
        CALL COLSET(1.0,0.6,0.0,9)
        CALL COLSET(1.0,0.4,0.2,10)
        CALL COLSET(0.6,0.4,0.2,11)
        CALL COLSET(0.6,0.2,0.4,12)
        CALL COLSET(0.8,0.2,0.6,13)
        CALL COLSET(0.6,0.6,1.0,14)
        CALL COLSET(0.0,0.6,0.2,15)
        CALL HSV
        CALL LINCOL(3)
        CALL CTRFNT(15)
        CALL PCSEND(1.0,0.05,'GHOST')
        CALL CTRFNT(1)
        CALL PSPACE(0.05,1.25,0.1,1.0)
        CALL SURCOL(0,0,4)
        CALL SURROT(20.0)
        CALL SURANG(70.0)
        CALL SURBAS(0,1,0.0)
        CALL SURCON(1)
        CALL SURAXE(0,0.0,0.0,0.0,0.0)
        CALL SURFL4(SURFAS,1,51,51,1,51,51,CLEVLS,1,11,
     &              SURFA1,1,101,1,101)
        CALL SURPLT(SURFAS,1,51,51,1,51,51)
      CALL LINCOL(0)
      CALL CTRFNT(14)
      CALL PSPACE(0.15,1.15,0.0,1.0)
      RETURN
      END
C
C========================================================================
C
      SUBROUTINE SPIC12(NPLANE)
C
      COMMON /DEMOAA/ SURFAS(51,51),CLEVLS(51),ICLARR(50,50),
     &                SURFA1(101,101),SURFA2(201,201)
C
        CALL LINCOL(3)
        CALL CTRFNT(15)
        CALL PCSEND(1.0,0.05,'GHOST')
        CALL CTRFNT(1)
        CALL PSPACE(0.05,1.25,0.1,1.0)
        CALL SURCOL(4,2,4)
        IF (NPLANE.EQ.1) CALL SURSKL(0.666667,14,2)
        IF (NPLANE.EQ.2) CALL SURSKL(0.666667,100,25)
C
        CALL SURLIT(-3.0,5.0,-13.0)
        CALL SURREF(1.0,0.2,0.8,0.8)
        CALL SURROT(120.0)
        CALL SURANG(70.0)
        CALL SURBAS(0,1,0.0)
        CALL SURAXE(0,0.0,0.0,0.0,0.0)
        CALL SURSHD(SURFA2,1,201,201,1,201,201)
      CALL LINCOL(0)
      CALL CTRFNT(14)
      CALL PSPACE(0.15,1.15,0.0,1.0)
      RETURN
      END
C
C========================================================================
C
      SUBROUTINE SPIC13
C
      INTEGER KOLS(3)
C
      COMMON /DEMOAA/ SURFAS(51,51),CLEVLS(51),ICLARR(50,50),
     &                SURFA1(101,101),SURFA2(201,201)
C
        L= 51
        K= L/10
        N= K/2+1
C
        DO 100 I=1,L
          DO 100 J=1,L
            IJ= I+J
            JI= I-J
            IF ((IJ.GE.L+1-K.AND.IJ.LE.L+1+K).OR.
     &          (JI.GE.-K.AND.JI.LE.K)) THEN
              SURFA1(I,J)= 1.0
            ELSE
              SURFA1(I,J)= 0.0
            ENDIF
C
          M= (L+1)/2
          IF (I.GE.M-K.AND.I.LE.M+K) SURFA1(I,J)= 1
          IF (J.GE.M-K.AND.J.LE.M+K) SURFA1(I,J)= 1
          IF (I.GE.M-N.AND.I.LE.M+N) SURFA1(I,J)= 2
          IF (J.GE.M-N.AND.J.LE.M+N) SURFA1(I,J)= 2
          IF (IJ.GE.L+1-N.AND.IJ.LE.L+1.AND.JI.LT.0.AND.
     &        J.GT.M+K) SURFA1(I,J)= 2
          IF (IJ.GE.L+1.AND.IJ.LE.L+1+N.AND.JI.GT.0.AND.
     &        J.LT.M-K) SURFA1(I,J)= 2
          IF (JI.GE.0.AND.JI.LE.N.AND.IJ.LT.L+1.AND.
     &        I.LT.M-K) SURFA1(I,J)= 2
          IF (JI.GE.-N.AND.JI.LE.0.AND.IJ.GT.L+1.AND.
     &        I.GT.M+K) SURFA1(I,J)= 2
C
  100   CONTINUE
C
        CLEVLS(1)= 0.5
        CLEVLS(2)= 1.5
        KOLS(1)= 4
        KOLS(2)= 5
        KOLS(3)= 2
        CALL LSTCOL(KOLS,3)
        CALL LINCOL(3)
        CALL CTRFNT(15)
        CALL PCSEND(1.0,0.05,'GHOST')
        CALL CTRFNT(1)
        CALL PSPACE(0.05,1.25,0.1,1.0)
        CALL SURCOL(6,0,4)
        CALL SURROT(10.0)
        CALL SURANG(80.0)
        CALL SURBAS(0,0,0.0)
        CALL SURCON(0)
        CALL SURIND(0)
        CALL SURAXE(0,0.0,0.0,0.0,0.0)
        CALL SURFL4(SURFAS,1,51,51,1,51,51,CLEVLS,1,2,
     &              SURFA1,1,101,1,101)
        CALL SURPLT(SURFAS,1,51,51,1,51,51)
      CALL LINCOL(0)
      CALL CTRFNT(14)
      CALL PSPACE(0.15,1.15,0.0,1.0)
      RETURN
      END
C
C========================================================================
C
      SUBROUTINE SPIC14
C
      INTEGER KOLS(2)
C
      COMMON /DEMOAA/ SURFAS(51,51),CLEVLS(51),ICLARR(50,50),
     &                SURFA1(101,101),SURFA2(201,201)
C
        L= 51
        K= L/10
C
        DO 100 I=1,L
          DO 100 J=1,L
            IJ= I+J
            JI= I-J
            IF ((IJ.GE.L+1-K.AND.IJ.LE.L+1+K).OR.
     &          (JI.GE.-K.AND.JI.LE.K)) THEN
              SURFA1(I,J)= 1.0
            ELSE
              SURFA1(I,J)= 0.0
            ENDIF
C
  100   CONTINUE
C
        CLEVLS(1)= 0.5
        KOLS(1)= 4
        KOLS(2)= 5
        CALL LSTCOL(KOLS,2)
        CALL LINCOL(3)
        CALL CTRFNT(15)
        CALL PCSEND(1.0,0.05,'GHOST')
        CALL CTRFNT(1)
        CALL PSPACE(0.05,1.25,0.1,1.0)
        CALL SURCOL(6,0,4)
        CALL SURROT(10.0)
        CALL SURANG(80.0)
        CALL SURBAS(0,0,0.0)
        CALL SURCON(0)
        CALL SURIND(0)
        CALL SURAXE(0,0.0,0.0,0.0,0.0)
        CALL SURFL4(SURFAS,1,51,51,1,51,51,CLEVLS,1,1,
     &              SURFA1,1,101,1,101)
        CALL SURPLT(SURFAS,1,51,51,1,51,51)
      CALL LINCOL(0)
      CALL CTRFNT(14)
      CALL PSPACE(0.15,1.15,0.0,1.0)
      RETURN
      END
C
C========================================================================
C
      SUBROUTINE SPIC1T
C
        CALL LINCOL(6)
        CALL PCSCEN(0.5,0.8,'GHOST has many routines for')
        CALL PCSCEN(0.5,0.65,'surface drawing.  The simplest')
        CALL PCSCEN(0.5,0.5,'draws a wire mesh from any angle.')
        CALL PCSCEN(0.5,0.35,'The base and underside are optional')
        CALL PCSCEN(0.5,0.2,'and may be differentiated by colour.')
      CALL LINCOL(0)
C
      RETURN
      END
C
C========================================================================
C
      SUBROUTINE SPIC2T
C
        CALL LINCOL(6)
        CALL PCSCEN(0.5,0.8,'Multiple views provide a')
        CALL PCSCEN(0.5,0.65,'good way of appreciating')
        CALL PCSCEN(0.5,0.5,'the whole surface.  The base is')
        CALL PCSCEN(0.5,0.35,'not drawn at negative elevations.')
        CALL PCSCEN(0.5,0.2,'Colours are under program control.')
      CALL LINCOL(0)
C
      RETURN
      END
C
C========================================================================
C
      SUBROUTINE SPIC3T
C
        CALL LINCOL(6)
        CALL PCSCEN(0.5,0.8,'The surface drawing may be')
        CALL PCSCEN(0.5,0.65,'made more useful by adding')
        CALL PCSCEN(0.5,0.5,'axes.  There are three different')
        CALL PCSCEN(0.5,0.35,'types of axis annotation but')
        CALL PCSCEN(0.5,0.2,'just one is illustrated.')
      CALL LINCOL(0)
C
      RETURN
      END
C
C========================================================================
C
      SUBROUTINE SPIC4T
C
        CALL LINCOL(6)
        CALL PCSCEN(0.5,0.8,'A fourth dimension may be added')
        CALL PCSCEN(0.5,0.65,'by filling each surface')
        CALL PCSCEN(0.5,0.5,'rectangle with a colour.  The')
        CALL PCSCEN(0.5,0.35,'colour used in the next drawing')
        CALL PCSCEN(0.5,0.2,'is a function of surface height.')
      CALL LINCOL(0)
C
      RETURN
      END
C
C========================================================================
C
      SUBROUTINE SPIC5T
C
        CALL LINCOL(6)
        CALL PCSCEN(0.5,0.8,'The clarity of the picture is')
        CALL PCSCEN(0.5,0.65,'improved by superimposing')
        CALL PCSCEN(0.5,0.5,'the wire frame drawing but')
        CALL PCSCEN(0.5,0.35,'without the underside and')
        CALL PCSCEN(0.5,0.2,'base lines being drawn.')
      CALL LINCOL(0)
C
      RETURN
      END
C
C========================================================================
C
      SUBROUTINE SPIC6T
C
        CALL LINCOL(6)
        CALL PCSCEN(0.5,0.8,'Reverting to a three dimensional')
        CALL PCSCEN(0.5,0.65,'drawing, the true contours')
        CALL PCSCEN(0.5,0.5,'can be calculated and shown in')
        CALL PCSCEN(0.5,0.35,'colour.  The diamond appearance')
        CALL PCSCEN(0.5,0.2,'of the last drawing now disappears.')
      CALL LINCOL(0)
C
      RETURN
      END
C
C========================================================================
C
      SUBROUTINE SPIC7T
C
        CALL LINCOL(6)
        CALL PCSCEN(0.5,0.8,'Adding the visible contour lines')
        CALL PCSCEN(0.5,0.65,'in a contrasting colour emphasises')
        CALL PCSCEN(0.5,0.5,'the contours.  The picture is')
        CALL PCSCEN(0.5,0.35,'completed by superimposing the')
        CALL PCSCEN(0.5,0.2,'wire frame grid and the axes.')
      CALL LINCOL(0)
C
      RETURN
      END
C
C========================================================================
C
      SUBROUTINE SPIC8T
C
        CALL LINCOL(6)
        CALL PCSCEN(0.5,0.8,'A surface may be sectioned from')
        CALL PCSCEN(0.5,0.65,'any point to any other point to')
        CALL PCSCEN(0.5,0.5,'show the contours as a layer cake.')
        CALL PCSCEN(0.5,0.35,'Axes may optionally be drawn, showing')
        CALL PCSCEN(0.5,0.2,'the x and y coordinates on the base.')
      CALL LINCOL(0)
C
      RETURN
      END
C
C========================================================================
C
      SUBROUTINE SPIC9T
C
        CALL LINCOL(6)
        CALL PCSCEN(0.5,0.8,'A different appearance may be')
        CALL PCSCEN(0.5,0.65,'created by increasing the')
        CALL PCSCEN(0.5,0.5,'number of contours and colouring')
        CALL PCSCEN(0.5,0.35,'them with different shades')
        CALL PCSCEN(0.5,0.2,'of the same basic colour.')
      CALL LINCOL(0)
C
      RETURN
      END
C
C========================================================================
C
      SUBROUTINE SPI10T
C
        CALL LINCOL(6)
        CALL PCSCEN(0.5,0.8,'A new dimension in surface')
        CALL PCSCEN(0.5,0.65,'drawing with')
        CALL CTRMAG(90)
        CALL PCSCEN(0.5,0.3,'GHOST')
        CALL CTRMAG(35)
      CALL LINCOL(0)
C
      RETURN
      END
C
C========================================================================
C
      SUBROUTINE SPI11T
C
        CALL LINCOL(6)
        CALL PCSCEN(0.5,0.8,'But....    that''s not all.')
        CALL PCSCEN(0.5,0.65,'GHOST can project the')
        CALL PCSCEN(0.5,0.5,'contour map of one surface')
        CALL PCSCEN(0.5,0.35,'onto the 3-D mesh of another')
        CALL PCSCEN(0.5,0.2,'giving a true 4-D image.')
      CALL LINCOL(0)
C
      RETURN
      END
C
C========================================================================
C
      SUBROUTINE SPI12T
C
        CALL LINCOL(6)
        CALL PCSCEN(0.5,0.8,'And....    finally,')
        CALL PCSCEN(0.5,0.65,'GHOST can draw a shaded image')
        CALL PCSCEN(0.5,0.5,'of the surface with control of')
        CALL PCSCEN(0.5,0.35,'colour, light source direction,')
        CALL PCSCEN(0.5,0.2,'ambient lighting and glossiness.')
      CALL LINCOL(0)
C
      RETURN
      END
C
C========================================================================
C
      SUBROUTINE SPI13T
C
        CALL LINCOL(6)
        CALL CTRMAG(90)
        CALL PCSCEN(0.5,0.8,'GHOST')
        CALL CTRMAG(35)
        CALL PCSCEN(0.5,0.5,'The fourth dimension in')
        CALL PCSCEN(0.5,0.35,'surface drawing.')
      CALL LINCOL(0)
C
      RETURN
      END
