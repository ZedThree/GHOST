      SUBROUTINE G5ERMS
C
C          ------------------------------------------------
C          ROUTINE NO. (5016)   VERSION (A7.1)    11:FEB:85
C                        === FORTRAN-77 ===
C          ------------------------------------------------
C
C          THIS PRINTS OUT THE APPROPRIATE TRANGRID DECODER
C          ERROR MESSAGE AFTER THE OCCURRENCE OF A READ ERROR.
C
C
      LOGICAL   TEROUT
      CHARACTER OUTPUT(3)*40
C
      COMMON /T3CHAM/ KMESGI,KMESGO
      COMMON /T5TERR/ INERR,TEROUT
C
C
      SAVE OUTPUT
      DATA OUTPUT /'END OF INPUT FILE REACHED               ',
     &             'ILLEGAL CHARACTER IN INPUT              ',
     &             'INCORRECT DATA LENGTH                   '/
C
C
      WRITE(KMESGO,201) '*** TRAND ERROR:  ',OUTPUT(INERR),' ***'
  201 FORMAT(/,5X,3A)
C
      RETURN
      END
