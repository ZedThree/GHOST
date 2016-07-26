      SUBROUTINE G0SDEL(IPOINT)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 358)   VERSION (A9.1)    06:OCT:92
C          ------------------------------------------------
C
C          THIS ROUTINE DELETES A POINT FROM THE LIST.
C
C
      PARAMETER (ISZARR= 1200)
C
      COMMON /T0SCHN/ LSTFRE(ISZARR),IFPNTR(ISZARR),IBPNTR(ISZARR),
     &                SXPOS(ISZARR),SYPOS(ISZARR),ISPNTR
C
C
      LSTFRE(IPOINT)= 0
      LSTPNT= IBPNTR(IPOINT)
      NXTPNT= IFPNTR(IPOINT)
      IBPNTR(IPOINT)= 0
      IFPNTR(IPOINT)= 0
      IF (NXTPNT.NE.0) IBPNTR(NXTPNT)= LSTPNT
      IF (LSTPNT.NE.0) IFPNTR(LSTPNT)= NXTPNT
      IF (ISPNTR.EQ.IPOINT) ISPNTR= NXTPNT
C
      RETURN
      END
