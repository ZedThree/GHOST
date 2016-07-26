      SUBROUTINE TYPENC(NCHAR)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 158)   VERSION (A7.3)    11:FEB:85
C          ------------------------------------------------
C
C          THIS DRAWS CHARACTER NO. <NCHAR> AT THE CURRENT POSITION.
C
C
C          THIS VERSION IS SUITABLE FOR MACHINES WITH
C          ANY TYPE OF CHARACTER CODING, BUT DOES NOT
C          SUPPORT ANY OF THE OLD GHOST CHARACTER SETS.
C
C          CHARACTERS ARE HELD IN: [CHAR]
C
C
      REAL    RDATA(1)
      INTEGER IDATA(1)
C
      DATA RDATA(1) /0.0/
C
C
      IDATA(1)= NCHAR
      IF (NCHAR.LT.0.OR.NCHAR.GT.255) IDATA(1)= 32
C
      CALL G3LINK(2,11,-1,IDATA,RDATA)
      RETURN
      END
