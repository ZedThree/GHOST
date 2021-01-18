      SUBROUTINE G0MESG(MSGNO,IMODE)
C
C          ------------------------------------------------
C          ROUTINE NO. (   8)   VERSION (A9.8)    01:MAR:93
C          ------------------------------------------------
C
C          THIS PRINTS OUT TRACE INFORMATION.
C
C
C          THE ARGUMENTS ARE AS FOLLOWS:
C
C          <MSGNO>  IDENTIFIES THE CALLING ROUTINE, AND
C          <IMODE>  SETS THE ARGUMENT TYPE:
C                   1-4, IT IS REAL FORMAT, OR
C                   5-8, IT IS INTEGER. ITS VALUE
C                   MODULO-4 GIVES THE NO. OF ARGS.
C
C
      REAL      RDATA(1),VALUE(4)
      INTEGER   IDATA(1),NUMBER(4)
      CHARACTER OUTPUT(199)*6,DLOAD1(64)*6,DLOAD2(64)*6,DLOAD3(64)*6,
     &          DLOAD4(7)*6
C
      COMMON /T0TRAR/ RTRAC1,RTRAC2,RTRAC3,RTRAC4
      COMMON /T0TRAI/ ITRAC1,ITRAC2,ITRAC3,ITRAC4
      COMMON /T3CHAM/ KMESGI,KMESGO
C
      EQUIVALENCE (VALUE(1),RTRAC1),       (NUMBER(1),ITRAC1),
     &            (OUTPUT(1),DLOAD1(1)),   (OUTPUT(65),DLOAD2(1)),
     &            (OUTPUT(129),DLOAD3(1)), (OUTPUT(193),DLOAD4(1))
C
C
      SAVE OUTPUT,DLOAD1,DLOAD2,DLOAD3,DLOAD4
      DATA DLOAD1 /'PAPER ','FILM  ','GREND ','FRAME ',
     &             'GPSTOP','GARGS ','MAP   ','MAPXL ',
     &             'MAPYL ','MAPXYL','WINDOW','PSPACE',
     &             'MASK  ','UNMASK','SCALE ','ROTATE',
     &             'SCAROT','RADIAN','DEGREE','GRAD  ',
     &             'QADRNT','BROKEN','FULL  ','LSTCOL',
     &             'THICK ','FLLBND','CONTRF','CONTIF',
     &             'AXINTS','BORDER','BOX   ','PTPLOT',
     &             'HISTGM','CURVEC','CURVEO','CURVEM',
     &             'INTENS','GRAPHF','GRAPHX','GRAPHC',
     &             'LINEF ','CIRCLE','ELLPSE','ARC   ',
     &             'ARCELL','LHRDW1','KHRDW1','CONTRA',
     &             'CONTRL','CONTIA','CONTIL','CDEFIN',
     &             'CTRMAG','CTRSIZ','CTRORI','CTRSLP',
     &             'ITALIC','UNDLIN','SUFFIX','SUPFIX',
     &             'NORMAL','CSPACE','PLACE ','SPACE '/
      DATA DLOAD2 /'HSPACE','LINEFD','HLINFD','CRLNFD',
     &             'AXNOTA','AXES  ','XAXIS ','YAXIS ',
     &             'AXESSI','XAXISI','YAXISI','AXEXL ',
     &             'AXEXLI','AXEYL ','AXEYLI','AXEXYL',
     &             'XAXISL','YAXISL','SCALES','SCALMX',
     &             'SCALMY','SCALSI','XSCALI','YSCALI',
     &             'SCAXL ','SCAXLI','SCAYL ','SCAYLI',
     &             'SCAXYL','XSCALL','YSCALL','GRATIC',
     &             'XGRAT ','YGRAT ','GRATSI','XGRATI',
     &             'YGRATI','GRAXL ','GRAXLI','GRAYL ',
     &             'GRAYLI','GRAXYL','XGRATL','YGRATL',
     &             'PTJOIN','PTGRAF','CTRFNT','CTROBL',
     &             'CTRANG','SELBUF','ENDBUF','UNLBUF',
     &             'CLRBUF','ERASE ','PICNOW','MARKER',
     &             'CRETRN','CHANNL','ERRORS','IOCHNL',
     &             'MAPFOL','WINFOL','WINCHR','COLSET'/
      DATA DLOAD3 /'RGB   ','HLS   ','HSI   ','FILCOL',
     &             'BARCHT','SECCIR','SECELL','PIECHT',
     &             'PIELBL','LINCOL','DEFPEN','MSKCHR',
     &             'LOCATE','UNLOC ','TPICT ','TCLIPA',
     &             'REGRID','SURPLT','SURDIR','SURBAS',
     &             'SURSEC','SURSCA','SURIND','SURANG',
     &             'SURCOL','ISOSUR','ANNOTP','AXORIG',
     &             'PIELBM','SURAXE','BARTYP','MULHIS',
     &             'MULBAR','VMENU ','VCHTKY','LBCOLS',
     &             'PIEANG','BARFLG','INCBAR','INCHIS',
     &             'HMENU ','HCHTKY','BAR3D ','BR3COL',
     &             'BR3ANG','BR3BAS','BR3RAT','CONLBL',
     &             'HATANG','HATCOL','HATDEF','HATLST',
     &             'HATPCH','HATPHS','HATSFT','HATYPE',
     &             'HATDUP','HATLSH','BR3LBL','HATOPT',
     &             'SURCL4','SURCON','SURCUT','SURFL4'/
      DATA DLOAD4 /'SURFLC','SURLIT','SURPLT','SURREF',
     &             'SURROT','SURSHD','SURSKL'/
C
C
      CALL G3LINK(3,10,0,IDATA,RDATA)
      NARGS= IMODE
      IF (NARGS.GT.4) NARGS= NARGS-4
      IF (IMODE.EQ.0) THEN
        WRITE(KMESGO,201) OUTPUT(MSGNO)
  201   FORMAT(5X,A6)
      ELSE
        IF (IMODE.LE.4) THEN
          WRITE(KMESGO,202) OUTPUT(MSGNO),(VALUE(IOUT), IOUT= 1,NARGS)
  202     FORMAT(5X,A6,4(2X,1PE13.6))
        ELSE
          WRITE(KMESGO,203) OUTPUT(MSGNO),(NUMBER(IOUT), IOUT= 1,NARGS)
  203     FORMAT(5X,A6,4(2X,I10))
        ENDIF
C
      ENDIF
C
      RETURN
      END
