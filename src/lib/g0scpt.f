      SUBROUTINE G0SCPT(XPOS,IPOINT)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 357)   VERSION (A9.1)    06:OCT:92
C          ------------------------------------------------
C
C          THIS ROUTINE SCANS THE LIST AND RETURNS THE
C          POINT NUMBER BELOW XPOS.
C
C
      PARAMETER (ISZARR= 1200)
C
      COMMON /T0SCHN/ LSTFRE(ISZARR),IFPNTR(ISZARR),IBPNTR(ISZARR),
     &                SXPOS(ISZARR),SYPOS(ISZARR),ISPNTR
C
C
      IPOINT= ISPNTR
    1 IF (XPOS.LT.SXPOS(IPOINT)) GO TO 2
      IF (IFPNTR(IPOINT).EQ.0) RETURN
C
      IPOINT= IFPNTR(IPOINT)
      GO TO 1
C
    2 IPOINT= IBPNTR(IPOINT)
      RETURN
      END
