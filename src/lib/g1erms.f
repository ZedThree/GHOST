      SUBROUTINE G1ERMS
C
C          ------------------------------------------------
C          ROUTINE NO. (1006)   VERSION (A8.5)    14:NOV:90
C                         === FORTRAN-77 ===
C          ------------------------------------------------
C
C          THIS PRINTS OUT THE APPROPRIATE POST-PROCESSOR
C          ERROR MESSAGE AFTER THE OCCURRENCE OF A FAULT.
C
C
      LOGICAL   ERRON
      CHARACTER MESSAG(8)*36
C
      COMMON /T3CHAM/ KMESGI,KMESGO
      COMMON /T3ERRS/ ERRON,NUMERR
C
      SAVE MESSAG
      DATA MESSAG /'ATTEMPT TO SET LOG. MAP THROUGH ZERO',
     &             'ATTEMPT TO MOVE OUTSIDE LOG. SPACE  ',
     &             'WORK SPACE COMPLETELY FULL          ',
     &             'CHARACTER-DEFINITION SPACE FULL     ',
     &             'UNABLE TO OPEN CHARACTER FONT FILE  ',
     &             'UNABLE TO READ CHARACTER FONT FILE  ',
     &             'DEVICE I/O SUSPENDED                ',
     &             'ERROR READING COMMAND LINE          '/
C
C
      MSGNO= NUMERR-1000
      WRITE(KMESGO,201) '*** DEVICE-OUTPUT ERROR: ',
     &                   MESSAG(MSGNO),' ***'
  201 FORMAT(/,5X,3A)
C
      RETURN
      END
