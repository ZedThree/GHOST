      SUBROUTINE G0ERMS
C
C          ------------------------------------------------
C          ROUTINE NO. (   9)   VERSION (A9.9)    12:OCT:95
C          ------------------------------------------------
C
C          THIS PRINTS OUT THE APPROPRIATE PRE-PROCESSOR
C          ERROR MESSAGE AFTER THE OCCURRENCE OF A FAULT.
C
C
      REAL      RDATA(1)
      INTEGER   IDATA(1)
      LOGICAL   ERRON
      CHARACTER MESSAG(61)*48,MESGP1(20)*48,MESGP2(20)*48,
     &          MESGP3(20)*48,MESGP4(1)*48
C
      COMMON /T3CHAM/ KMESGI,KMESGO
      COMMON /T3ERRS/ ERRON,NUMERR
C
      EQUIVALENCE (MESGP1(1),MESSAG( 1)),(MESGP2(1),MESSAG(21)),
     &            (MESGP3(1),MESSAG(41)),(MESGP4(1),MESSAG(61))
C
      SAVE MESSAG,MESGP1,MESGP2,MESGP3
      DATA MESGP1 /'PSPACE: BOTH EXTENTS MUST HAVE NON-ZERO WIDTH   ',
     &             'GHOST:  LOG. MAPPING ATTEMPTED THROUGH ZERO     ',
     &             'MASK:   MORE THAN 10 MASK-AREAS REQUESTED       ',
     &             'UNMASK: INCORRECT MASK-AREA NUMBER              ',
     &             'GHOST:  INVALID DATA FOR AUTOMATIC MAPPING      ',
     &             'SELBUF: INCORRECT BUFFER NUMBER                 ',
     &             'UNLBUF: INCORRECT BUFFER NUMBER                 ',
     &             'CLRBUF: INCORRECT BUFFER NUMBER                 ',
     &             'BAR3D : INVALID ARRAY SIZE PARAMETERS           ',
     &             'CURVEM: INCORRECT METHOD NUMBER                 ',
     &             'CONTRA: INVALID ARRAY SIZE PARAMETERS           ',
     &             'CONTRL: INVALID ARRAY SIZE PARAMETERS           ',
     &             'CONTIA: INVALID ARRAY SIZE PARAMETERS           ',
     &             'CONTIL: INVALID ARRAY SIZE PARAMETERS           ',
     &             'SUFFIX: MORE THAN 5 SUFFIXES ATTEMPTED          ',
     &             'SUPFIX: MORE THAN 5 SUPERFIXES ATTEMPTED        ',
     &             'NORMAL: ATTEMPTED RETURN TO NONEXISTENT LEVEL   ',
     &             'GHOST:  TEXT STRING TRUNCATED                   ',
     &             'GHOST:  FILE OR PICTURE NAME TRUNCATED          ',
     &             'GHOST:  SYNTAX ERROR IN STRING COMMAND SEQUENCE '/
      DATA MESGP2 /'CDEFIN: CONSTANT CHARACTERS CANNOT BE REDEFINED ',
     &             'CDEFIN: CHARACTER DEFINITION IS INCORRECT       ',
     &             'BR3LBL: INVALID ARRAY SIZE PARAMETERS           ',
     &             'PIELBM: INCORRECT METHOD NUMBER                 ',
     &             'PIELBL: MORE THAN 50 SECTORS IN PIE CHART       ',
     &             'PIELBL: DIFFERENT NUMBER OF LABELS AND SECTORS  ',
     &             'CRETRN: TYPEWRITER MODE HAS NOT BEEN SET        ',
     &             'CRLNFD: TYPEWRITER MODE HAS NOT BEEN SET        ',
     &             'PLACE:  TYPEWRITER MODE HAS NOT BEEN SET        ',
     &             'TYPENF: INVALID NUMBER OF SIG. DIGITS REQUESTED ',
     &             'TYPENE: INVALID NUMBER OF SIG. DIGITS ATTEMPTED ',
     &             'GHOST:  MORE THAN 20 LOG.-AXIS CYCLES ATTEMPTED ',
     &             'MARKER: INCORRECT CHARACTER NUMBER              ',
     &             'COLSET: ONE OR MORE PRIMARY COLOURS SATURATED   ',
     &             'REGRID: NOT ENOUGH DATA OR GRID POINTS          ',
     &             'REGRID: FAILURE IN INTERPOLATION ROUTINE        ',
     &             'SURPLT: INVALID ARRAY SIZE PARAMETERS           ',
     &             'SURBAS: INVALID VALUE OF BASE TYPE PARAMETER    ',
     &             'SURAXE: INVALID VALUE OF AXIS ANNOTATION TYPE   ',
     &             'SURSHD: INVALID ARRAY SIZE PARAMETERS           '/
      DATA MESGP3 /'GHOST:  INTERNAL ARRAY O/FLOW IN SURFACE ROUTINE',
     &             'SURREF: BRIGHTNESS COEFFICIENT OUT OF RANGE     ',
     &             'SURREF: AMBIENT LIGHT COEFFIECIENT OUT OF RANGE ',
     &             'SURREF: DIFFUSE LIGHT COEFFIECIENT OUT OF RANGE ',
     &             'SURREF: GLOSSINESS COEFFIECIENT OUT OF RANGE    ',
     &             'SURCL4: INVALID ARRAY SIZE PARAMETERS           ',
     &             'SURCUT: INVALID ARRAY SIZE PARAMETERS           ',
     &             'SURFL4: INVALID ARRAY SIZE PARAMETERS           ',
     &             'SURFLC: INVALID ARRAY SIZE PARAMETERS           ',
     &             'CONTRF: INVALID ARRAY SIZE PARAMETERS           ',
     &             'CONTIF: INVALID ARRAY SIZE PARAMETERS           ',
     &             'CONTRF: CONTOURS NOT MONOTONICALLY INCREASING   ',
     &             'CONTIF: CONTOURS NOT MONOTONICALLY INCREASING   ',
     &             'SURCUT: CONTOURS NOT MONOTONICALLY INCREASING   ',
     &             'SURFL4: CONTOURS NOT MONOTONICALLY INCREASING   ',
     &             'SURFLC: CONTOURS NOT MONOTONICALLY INCREASING   ',
     &             'SURCL4: ELEVATION VIEW ANGLE MAY NOT BE NEGATIVE',
     &             'SURFL4: ELEVATION VIEW ANGLE MAY NOT BE NEGATIVE',
     &             'SURFLC: ELEVATION VIEW ANGLE MAY NOT BE NEGATIVE',
     &             'SURSHD: ELEVATION VIEW ANGLE MAY NOT BE NEGATIVE'/
      DATA MESGP4 /'HATDEF: PATTERN NOS 1 TO 64 MAY NOT BE REDEFINED'/
C
C
      CALL G3LINK(3,10,0,IDATA,RDATA)
      WRITE(KMESGO,201) '*** ERROR IN ',MESSAG(NUMERR),' ***'
  201 FORMAT(/,5X,3A)
C
      RETURN
      END
