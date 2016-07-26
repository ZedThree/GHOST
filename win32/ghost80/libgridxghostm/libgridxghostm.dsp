# Microsoft Developer Studio Project File - Name="libgridxghostm" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Static Library" 0x0104

CFG=libgridxghostm - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "libgridxghostm.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "libgridxghostm.mak" CFG="libgridxghostm - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "libgridxghostm - Win32 Release" (based on "Win32 (x86) Static Library")
!MESSAGE "libgridxghostm - Win32 Debug" (based on "Win32 (x86) Static Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
F90=df.exe
RSC=rc.exe

!IF  "$(CFG)" == "libgridxghostm - Win32 Release"

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
# ADD F90 /compile_only /define:GHOST_RECL_UNIT=4 /libs:dll /nologo /reentrancy:threaded /warn:nofileopt /fpp:"/m"
# SUBTRACT F90 /libdir:noauto /threads
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /YX /FD /c
# ADD CPP /nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /YX /FD /D GHOST_EXEC_PREFIX="\"C:/Program Files/Culham\"" /c
# ADD BASE RSC /l 0x809 /d "NDEBUG"
# ADD RSC /l 0x809 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:"Release\gridxghostm.lib"

!ELSEIF  "$(CFG)" == "libgridxghostm - Win32 Debug"

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
# ADD F90 /check:bounds /compile_only /debug:full /define:GHOST_RECL_UNIT=4 /libs:dll /nologo /reentrancy:threaded /traceback /warn:argument_checking /warn:nofileopt /fpp:"/m"
# SUBTRACT F90 /libdir:noauto /threads
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /YX /FD /GZ /c
# ADD CPP /nologo /MD /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /YX /FD /GZ /D GHOST_EXEC_PREFIX="\"C:/Program Files/Culham\"" /c
# ADD BASE RSC /l 0x809 /d "_DEBUG"
# ADD RSC /l 0x809 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:"Debug\gridxghostm.lib"

!ENDIF 

# Begin Target

# Name "libgridxghostm - Win32 Release"
# Name "libgridxghostm - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat;f90;for;f;fpp"
# Begin Source File

SOURCE=..\..\..\src\lib\g1char.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1chio.F
# ADD F90 /fpp
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1chsp.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1clip.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1cls0.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1cls2.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1cls3.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1cls4.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1cls5.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1cls7.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1clsna.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1cmlna.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1conc.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1crv1.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1disc.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1erms.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1filb.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1hrdwx11.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1initx11.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1line.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1mapp.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1marv.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1movc.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1shad.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1spec.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1tranx11.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1vectx11.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g2buff.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g2ermsb.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g2file.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g2shutb.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g2sysi.F
# ADD F90 /fpp
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g3flina.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g3flsva.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g3grinb.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g3initc.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g3linkc.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g3sysi.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g4bacod.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g4cocod.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g4getb.c
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g4getc.c
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g4getk.c
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g4putb.c
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g4putc.c
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g4putk.c
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\lenstr.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\xgenieIF.c
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl;fi;fd"
# Begin Source File

SOURCE=..\..\..\src\lib\Opcodes.h
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\xgenie.h
# End Source File
# End Group
# End Target
# End Project
