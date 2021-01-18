# Microsoft Developer Studio Project File - Name="libtrenc" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Static Library" 0x0104

CFG=libtrenc - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "libtrenc.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "libtrenc.mak" CFG="libtrenc - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "libtrenc - Win32 Release" (based on "Win32 (x86) Static Library")
!MESSAGE "libtrenc - Win32 Debug" (based on "Win32 (x86) Static Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
F90=df.exe
RSC=rc.exe

!IF  "$(CFG)" == "libtrenc - Win32 Release"

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
# ADD F90 /compile_only /define:GHOST_RECL_UNIT=4 /nologo /warn:nofileopt /fpp:"/m"
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /YX /FD /c
# ADD CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /YX /FD /c
# ADD BASE RSC /l 0x809 /d "NDEBUG"
# ADD RSC /l 0x809 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:"Release\trenc.lib"

!ELSEIF  "$(CFG)" == "libtrenc - Win32 Debug"

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
# ADD F90 /check:bounds /compile_only /debug:full /define:GHOST_RECL_UNIT=4 /nologo /traceback /warn:argument_checking /warn:nofileopt /fpp:"/m"
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /YX /FD /GZ /c
# ADD CPP /nologo /ML /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /YX /FD /GZ /c
# ADD BASE RSC /l 0x809 /d "_DEBUG"
# ADD RSC /l 0x809 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:"Debug\trenc.lib"

!ENDIF 

# Begin Target

# Name "libtrenc - Win32 Release"
# Name "libtrenc - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat;f90;for;f;fpp"
# Begin Source File

SOURCE=..\..\..\src\lib\g1clsna.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1cmlna.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1dviotg.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1erms.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1hrdwtg.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1inittg.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g1trantg.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g3flind.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g3flsvb.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g3grina.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g3initb.f
# End Source File
# Begin Source File

SOURCE=..\..\..\src\lib\g3linkd.f
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
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl;fi;fd"
# End Group
# End Target
# End Project
