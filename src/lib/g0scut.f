      SUBROUTINE G0SCUT(XPOS1,XPOS2,SURF1,SURF2,YSCALE,SURMIN,
     &                  CLEVLS,ISTRTL,ISTOPL)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 368)   VERSION (A9.1)    12:MAY:92
C          ------------------------------------------------
C
      REAL CLEVLS(ISTOPL),XSTORE(5),YSTORE(5)
C
      COMMON /T0SCON/ JCONTR
C
C
      IF (SURF1.LT.SURF2) THEN
        SURMN= SURF1
        SURMX= SURF2
        MINSID= 1
      ELSE
        SURMN= SURF2
        SURMX= SURF1
        MINSID= 2
      ENDIF
C
      XPOSL= XPOS1
      XPOSR= XPOS2
      YPOS= 0.0
      SURPOS= SURMIN
      KCONT= 0
C
      DO 100 I= ISTRTL,ISTOPL+1
        IF (I.LE.ISTOPL) THEN
          HT= CLEVLS(I)
        ELSE
          HT= SURMX
        ENDIF
C
        IF (HT.GT.SURPOS.AND.SURPOS.LE.SURMX) THEN
          KCONT= KCONT+1
          XSTORE(1)= XPOS1
          XSTORE(2)= XPOS1
          XSTORE(3)= XPOS2
          XSTORE(4)= XPOS2
          YSTORE(1)= (SURPOS-SURMIN)*YSCALE
          IF (HT.LE.SURMN) THEN
C
C          RECTANGULAR BOTTOM SECTION.
C
            YSTORE(2)= (HT-SURMIN)*YSCALE
            YSTORE(3)= YSTORE(2)
            YSTORE(4)= YSTORE(1)
            CALL G0SFLP(XSTORE,YSTORE,4,I)
            SURPOS= HT
            IF (JCONTR.EQ.1.AND.KCONT.GT.1) THEN
              CALL POSITN(XPOS1,YSTORE(1))
              CALL JOIN(XPOS2,YSTORE(1))
            ENDIF
C
          ELSE
C
C          INTERMEDIATE AND FINAL SECTIONS.
C
            IF (HT.LT.SURMX) THEN
C
C          INTERMEDIATE SECTION.
C
              IF (SURPOS.LT.SURMN) THEN
C
C          PENTAGON INTERMEDIATE SECTION.
C
                XSTORE(5)= XPOS2
                YSTORE(5)= YSTORE(1)
                IF (MINSID.EQ.1) THEN
                  XSTORE(3)= XPOS1+(HT-SURMN)*(XPOS2-XPOS1)/
     &                       (SURMX-SURMN)
                  YSTORE(2)= (SURMN-SURMIN)*YSCALE
                  YSTORE(3)= (HT-SURMIN)*YSCALE
                  YSTORE(4)= YSTORE(3)
                  CALL G0SFLP(XSTORE,YSTORE,5,I)
                  IF (JCONTR.EQ.1) THEN
                    CALL POSITN(XSTORE(2),YSTORE(2))
                    CALL JOIN(XSTORE(3),YSTORE(3))
                  ENDIF
C
                ELSE
                  XSTORE(3)= XPOS2-(HT-SURMN)*(XPOS2-XPOS1)/
     &                       (SURMX-SURMN)
                  YSTORE(2)= (HT-SURMIN)*YSCALE
                  YSTORE(3)= YSTORE(2)
                  YSTORE(4)= (SURMN-SURMIN)*YSCALE
                  CALL G0SFLP(XSTORE,YSTORE,5,I)
                  IF (JCONTR.EQ.1) THEN
                    CALL POSITN(XSTORE(4),YSTORE(4))
                    CALL JOIN(XSTORE(3),YSTORE(3))
                  ENDIF
C
                ENDIF
C
                IF (JCONTR.EQ.1.AND.KCONT.GT.1) THEN
                  CALL POSITN(XPOS1,YSTORE(1))
                  CALL JOIN(XPOS2,YSTORE(1))
                ENDIF
C
              ELSE
C
C          QUADRILATERAL INTERMEDIATE SECTION.
C
                YSTORE(2)= (HT-SURMIN)*YSCALE
                YSTORE(3)= YSTORE(2)
                YSTORE(4)= YSTORE(1)
                IF (MINSID.EQ.1) THEN
                  XSTORE(1)= XPOS1+(SURPOS-SURMN)*(XPOS2-XPOS1)/
     &                       (SURMX-SURMN)
                  XSTORE(2)= XPOS1+(HT-SURMN)*(XPOS2-XPOS1)/
     &                       (SURMX-SURMN)
                  XSTORE(3)= XPOS2
                  XSTORE(4)= XPOS2
                  CALL G0SFLP(XSTORE,YSTORE,4,I)
                  IF (JCONTR.EQ.1) THEN
                    CALL POSITN(XSTORE(2),YSTORE(2))
                    CALL JOIN(XSTORE(1),YSTORE(1))
                    IF (KCONT.GT.1)
     &                CALL JOIN(XSTORE(4),YSTORE(4))
C
                  ENDIF
C
                ELSE
                  XSTORE(1)= XPOS1
                  XSTORE(2)= XPOS1
                  XSTORE(3)= XPOS2-(HT-SURMN)*(XPOS2-XPOS1)/
     &                       (SURMX-SURMN)
                  XSTORE(4)= XPOS2-(SURPOS-SURMN)*(XPOS2-XPOS1)/
     &                       (SURMX-SURMN)
                  CALL G0SFLP(XSTORE,YSTORE,4,I)
                  IF (JCONTR.EQ.1) THEN
                    CALL POSITN(XSTORE(3),YSTORE(3))
                    CALL JOIN(XSTORE(4),YSTORE(4))
                    IF (KCONT.GT.1)
     &                CALL JOIN(XSTORE(1),YSTORE(1))
C
                  ENDIF
C
                ENDIF
C
              ENDIF
C
            ELSE
C
C          FINAL SECTION.
C
              IF (SURPOS.LT.SURMN) THEN
C
C          QUADRILATERAL FINAL SECTION.
C
                IF (MINSID.EQ.1) THEN
                  YSTORE(2)= (SURMN-SURMIN)*YSCALE
                  YSTORE(3)= (SURMX-SURMIN)*YSCALE
                ELSE
                  YSTORE(2)= (SURMX-SURMIN)*YSCALE
                  YSTORE(3)= (SURMN-SURMIN)*YSCALE
                ENDIF
C
                YSTORE(4)= YSTORE(1)
                CALL G0SFLP(XSTORE,YSTORE,4,I)
                IF (JCONTR.EQ.1) THEN
                  CALL POSITN(XSTORE(2),YSTORE(2))
                  CALL JOIN(XSTORE(3),YSTORE(3))
                  IF (KCONT.GT.1) THEN
                    CALL POSITN(XSTORE(1),YSTORE(1))
                    CALL JOIN(XSTORE(4),YSTORE(4))
                  ENDIF
C
                ENDIF
C
              ELSE
C
C          TRIANGULAR FINAL SECTION.
C
                YSTORE(2)= YSTORE(1)
                YSTORE(3)= (SURMX-SURMIN)*YSCALE
                IF (MINSID.EQ.1) THEN
                  XSTORE(1)= XPOS1+(SURPOS-SURMN)*(XPOS2-XPOS1)/
     &                       (SURMX-SURMN)
                  XSTORE(2)= XPOS2
                  XSTORE(3)= XPOS2
                  CALL G0SFLP(XSTORE,YSTORE,3,I)
                  IF (JCONTR.EQ.1) THEN
                    CALL POSITN(XSTORE(3),YSTORE(3))
                    CALL JOIN(XSTORE(1),YSTORE(1))
                    IF (KCONT.GT.1)
     &                CALL JOIN(XSTORE(2),YSTORE(2))
C
                  ENDIF
C
                ELSE
                  XSTORE(1)= XPOS1
                  XSTORE(2)= XPOS2-(SURPOS-SURMN)*(XPOS2-XPOS1)/
     &                       (SURMX-SURMN)
                  XSTORE(3)= XPOS1
                  CALL G0SFLP(XSTORE,YSTORE,3,I)
                  IF (JCONTR.EQ.1) THEN
                    CALL POSITN(XSTORE(3),YSTORE(3))
                    CALL JOIN(XSTORE(2),YSTORE(2))
                    IF (KCONT.GT.1)
     &                CALL JOIN(XSTORE(1),YSTORE(1))
C
                  ENDIF
C
                ENDIF
C
              ENDIF
C
            ENDIF
C
            SURPOS= HT
          ENDIF
C
        ENDIF
C
  100 CONTINUE
C
      RETURN
      END
