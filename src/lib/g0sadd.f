      SUBROUTINE G0SADD(XPOS,YPOS)
C
C          ------------------------------------------------
C          ROUTINE NO. ( 352)   VERSION (A9.1)    13:JAN:94
C          ------------------------------------------------
C
C          THIS ROUTINE ADDS A POINT TO THE LIST.
C
C
      PARAMETER (ISZARR= 1200)
      LOGICAL ERRON
C
      COMMON /T0SCHN/ LSTFRE(ISZARR),IFPNTR(ISZARR),IBPNTR(ISZARR),
     &                SXPOS(ISZARR),SYPOS(ISZARR),ISPNTR
      COMMON /T3ERRS/ ERRON,NUMERR
C
C
      CALL G0SCPT(XPOS,IPOINT)
      NXTPOI= ISPNTR
      IF (IPOINT.NE.0) NXTPOI= IFPNTR(IPOINT)
C
C          SCAN THE LIST FOR A FREE ENTRY.
C
      DO 100 ISCAN= 1,ISZARR
        IF (LSTFRE(ISCAN).EQ.0) GO TO 1
  100 CONTINUE
C
      GO TO 901
C
C          UPDATE THE CHAINED LIST.
C
    1 LSTFRE(ISCAN)= 1
      IFPNTR(ISCAN)= NXTPOI
      IBPNTR(ISCAN)= IPOINT
      SXPOS(ISCAN)= XPOS
      SYPOS(ISCAN)= YPOS
      IF (IPOINT.NE.0) IFPNTR(IPOINT)= ISCAN
      IF (IPOINT.EQ.0) ISPNTR= ISCAN
      IF (NXTPOI.NE.0) IBPNTR(NXTPOI)= ISCAN
C
      RETURN
C
C          CHAINED LIST IS FULL.
C
  901 NUMERR= 41
      IF (ERRON) CALL G0ERMS
      STOP
      END
