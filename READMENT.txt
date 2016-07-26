BUILDING GHOST 80 ON WINDOWS NT/2000
====================================

Ghost has been built using Microsoft Visual C++ 6.0 SP3 and
Compaq Visual Fortran 6.6. The Developer Studio Workspace file
is in the win32/ghost80 directory.

There are two options for providing interactive graphics:

1) Use freewrap, http://home.nycap.rr.com/dlabelle/freewrap/freewrap.html,
to convert xgenie.tcl into xgenie.exe.

2) Use the Exceed XDK to compile xgeniex.exe and rename it xgenie.exe
or set the XGENIE environment variable to point to the version
of xgeine you want to use (use a version of the pathname without
spaces). (Tested with Exceed XDK 7.0.)

xgenie needs to be frewrapped by hand.

The fonts need to be built by hand (see
src/hershey/Makefile.am).

Ghost should be installed by hand in 
C:/Program Files/Culham/bin,
C:/Program Files/Culham/lib,
C:/Program Files/Culham/lib/fonts and
C:/Program Files/Culham/libexec
using the same structure as Unix.

NB Some of the projects assume that the software is in the
directory I:\ghost - some include file paths will need updating
if this is not the case.
