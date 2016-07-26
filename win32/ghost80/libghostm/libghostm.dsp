# Microsoft Developer Studio Project File - Name="libghostm" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Static Library" 0x0104

CFG=libghostm - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "libghostm.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "libghostm.mak" CFG="libghostm - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "libghostm - Win32 Release" (based on "Win32 (x86) Static Library")
!MESSAGE "libghostm - Win32 Debug" (based on "Win32 (x86) Static Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
F90=df.exe
RSC=rc.exe

!IF  "$(CFG)" == "libghostm - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
# ADD BASE F90 /compile_only /nologo /warn:nofileopt
# ADD F90 /compile_only /libs:dll /nologo /reentrancy:threaded /warn:nofileopt
# SUBTRACT F90 /libdir:noauto /threads
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /YX /FD /c
# ADD CPP /nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /YX /FD /c
# ADD BASE RSC /l 0x809 /d "NDEBUG"
# ADD RSC /l 0x809 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:"Release\ghostm.lib"

!ELSEIF  "$(CFG)" == "libghostm - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Target_Dir ""
# ADD BASE F90 /check:bounds /compile_only /debug:full /nologo /traceback /warn:argument_checking /warn:nofileopt
# ADD F90 /check:bounds /compile_only /debug:full /libs:dll /nologo /reentrancy:threaded /traceback /warn:argument_checking /warn:nofileopt
# SUBTRACT F90 /libdir:noauto /threads
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /YX /FD /GZ /c
# ADD CPP /nologo /MD /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /YX /FD /GZ /c
# ADD BASE RSC /l 0x809 /d "_DEBUG"
# ADD RSC /l 0x809 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:"Debug\ghostm.lib"

!ENDIF 

# Begin Target

# Name "libghostm - Win32 Release"
# Name "libghostm - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat;f90;for;f;fpp"
# Begin Source File

SOURCE=..\..\..\src\lib\annotp.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\arc.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\arcell.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\axes.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\axessi.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\axexl.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\axexli.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\axexyl.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\axeyl.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\axeyli.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\axints.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\axnota.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\axorig.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\baccol.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\bar3d.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\barcht.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\barflg.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\bartyp.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\border.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\box.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\br3ang.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\br3bas.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\br3col.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\br3lbl.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\br3rat.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\broken.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\cdefin.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\channl.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\circle.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\clrbuf.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\colset.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\conlbl.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\conota.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\contia.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\contif.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\contil.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\contra.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\contrf.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\contrl.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\coords.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\cretrn.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\crlnfd.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\cspace.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\ctrang.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\ctrfnt.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\ctrmag.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\ctrobl.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\ctrori.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\ctrsiz.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\ctrslp.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\cursor.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\curvec.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\curvem.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\curveo.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\defpen.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\degree.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\devoff.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\devon.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\ellpse.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\endbuf.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\enqaxi.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\enqchr.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\enqcon.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\enqcro.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\enqdat.c
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\enqerr.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\enqhat.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\enqinf.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\enqioc.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\enqlin.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\enqmap.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\enqmsk.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\enqpos.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\enqrun.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\enqtim.c
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\enqtra.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\erase.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\errbar.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\errors.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\filcol.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\filend.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\filinf.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\filnam.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\filoff.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\filon.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\fllbnd.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\frame.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\full.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0auto.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0cfl1.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0cfl2.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0cfl3.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0cfl4.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0cfl5.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0coni.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0cplt.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0ctia.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0ctra.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0curv.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0divl.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0divs.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0erms.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0fram.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0gpos.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0insd.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0intr.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0mapp.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0maps.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0mesg.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0olap.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0plax.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0play.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0plxl.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0plyl.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0sadd.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0sax1.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0sax2.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0scl4.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0sclp.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0scpt.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0scut.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0sdel.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0sfl4.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0sflc.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0sflp.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0shad.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0sind.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0sini.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0sizs.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0smat.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0splt.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0sshd.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0tick.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g0vecs.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g4nexc.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g4nexi.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g4nexr.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g4nexs.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\gargs.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\gksdev.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\gpstop.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\grad.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\graphc.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\graphf.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\graphx.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\gratic.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\gratsi.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\graxl.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\graxli.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\graxyl.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\grayl.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\grayli.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\grend.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\hatang.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\hatcol.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\hatdef.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\hatdup.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\hatlsh.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\hatlst.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\hatopt.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\hatpch.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\hatphs.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\hatsft.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\hatype.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\hchtky.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\histgm.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\hlinfd.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\hls.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\hmenu.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\hrdchr.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\hrdlin.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\hsi.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\hspace.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\hsv.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\incbar.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\inchis.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\intens.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\intrp1.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\intrp2.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\iochnl.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\isosur.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\italic.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\join.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\lbcols.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\lincol.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\line.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\linef.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\linefd.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\locate.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\lstcol.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\map.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\mapfol.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\mapxl.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\mapxyl.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\mapyl.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\marker.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\mask.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\matcol.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\move.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\movept.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\mskchr.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\mulbar.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\mulhis.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\normal.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\offbar.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\paper.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\pcscen.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\pcsend.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\picinf.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\picnam.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\picnow.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\picsav.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\pictur.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\pieang.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\piecht.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\pielbl.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\pielbm.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\place.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\plotcs.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\plotnc.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\plotne.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\plotnf.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\plotni.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\plotst.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\point.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\positn.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\pspace.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\ptgraf.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\ptjoin.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\ptplot.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\qadrnt.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\radian.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\regrid.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\rgb.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\rotate.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\scale.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\scales.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\scalsi.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\scarot.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\scaxl.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\scaxli.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\scaxyl.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\scayl.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\scayli.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\seccir.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\secell.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\selbuf.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\space.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\suffix.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\supfix.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\surang.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\suraxe.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\surbas.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\surcl4.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\surcol.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\surcon.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\surcut.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\surfl4.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\surflc.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\surind.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\surlit.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\surplt.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\surref.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\surrot.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\sursca.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\surshd.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\surskl.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\swichr.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\tablet.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\tclipa.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\tcscen.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\tcsend.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\thick.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\tpict.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\typecsb.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\typenc.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\typene.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\typenf.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\typeni.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\typest.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\undlin.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\unlbuf.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\unloc.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\unmask.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\vchtky.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\vmenu.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\winchr.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\window.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\winfol.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\xaxis.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\xaxisi.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\xaxisl.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\xgrat.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\xgrati.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\xgratl.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\xscale.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\xscali.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\xscall.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\yaxis.f

!IF  "$(CFG)" == "libghostm - Win32 Release"

!ELSEIF  "$(CFG)" == "libghostm - Win32 Debug"

# SUBTRACT F90 /fpp

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\yaxisi.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\yaxisl.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\ygrat.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\ygrati.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\ygratl.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\yscale.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\yscali.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\yscall.f
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl;fi;fd"
# End Group
# End Target
# End Project
