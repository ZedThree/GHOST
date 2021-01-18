      SUBROUTINE G2ERMS
C
C          ------------------------------------------------
C          ROUTINE NO. (2006)   VERSION (A7.6A)   11:FEB:85
C                         === FORTRAN-77 ===
C          ------------------------------------------------
C
C          THIS PRINTS OUT THE APPROPRIATE GRIDFILE-HANDLER
C          ERROR MESSAGE AFTER THE OCCURRENCE OF A FAULT.
C
C          (THIS VERSION IS FOR FILE MODE WORKING).
C
C
      LOGICAL   ERRON
      CHARACTER MESSAG(14)*36
C
      COMMON /T3CHAM/ KMESGI,KMESGO
      COMMON /T3ERRS/ ERRON,NUMERR
C
      SAVE MESSAG
      DATA MESSAG /'REQUESTED FILE DOES NOT EXIST       ',
     &             'REQUESTED FILE CANNOT BE CREATED    ',
     &             'REQUESTED FILE CANNOT BE ACCESSED   ',
     &             'REQUESTED FILE CANNOT BE CLOSED     ',
     &             'A FILE-POSITION ATTEMPT HAS FAILED  ',
     &             'A READ ATTEMPT HAS FAILED           ',
     &             'A WRITE-ATTEMPT HAS FAILED          ',
     &             'NO WRITE ALLOWED TO READ-ONLY FILE  ',
     &             'THE CURRENT PICTURE IS CORRUPT      ',
     &             'REQUESTED FILE CANNOT BE DELETED    ',
     &             'REQUESTED PICTURE DOES NOT EXIST    ',
     &             'LENGTH OF FILENAME WAS INCORRECT    ',
     &             'GRIDFILE I/O SUSPENDED              ',
     &             'CURRENT PICTURE LIMIT EXCEEDED      '/
C
C
      MSGNO= NUMERR-2000
      WRITE(KMESGO,201) '*** GRIDFILE ERROR: ',
     &                   MESSAG(MSGNO),' ***'
  201 FORMAT(/,5X,3A)
C
      RETURN
      END
