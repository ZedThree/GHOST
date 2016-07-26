      SUBROUTINE ITALIC(ITAL)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 146)   VERSION (A7.4)    11:FEB:85
C          ------------------------------------------------
C
C          THIS SETS CHARACTERS AS UPRIGHT OR ITALIC.
C
C
C          <ITAL>   CONTROLS THE CHARACTER STYLE:
C                   ZERO, IT IS UPRIGHT FORM, OR
C                   NON-ZERO, IT IS ITALIC FORM.
C
C
      REAL    RDATA(1)
      INTEGER IDATA(1)
C
      COMMON /T0CATT/ IUNDL0,ITAL0
      COMMON /T0TRAC/ IPRINT
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
C
      DATA RDATA /0.0/
C
C
      CALL G3INIT(2)
C
      ITRAC1= ITAL
      IF (IPRINT.EQ.1) CALL G0MESG(57,5)
C
      ITAL0= 0
      IF (ITAL.NE.0) ITAL0= 1
      IDATA(1)= ITAL0
      CALL G3LINK(2,6,-1,IDATA,RDATA)
C
      RETURN
      END
