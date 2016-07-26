## Process this file with automake to produce Makefile.in

## Do not require GNU tools
AUTOMAKE_OPTIONS = foreign no-dependencies

EXTRA_DIST = xgenie.tcl

libexec_PROGRAMS = xgenie

wraplibexecdir = $(prefix)/libexec
wraplibexec_SCRIPTS = xgenie.tcl

xgenie_SOURCES = xgenie.c Plot.c PlotGraphics.c PlotReplay.c Plot.h PlotP.h ghost.xbm

Plot.o: Plot.c PlotP.h Plot.h
PlotGraphics.o: PlotGraphics.c PlotP.h Plot.h
PlotReplay.o: PlotReplay.c PlotP.h Plot.h
xgenie.o: xgenie.c ghost.xbm Plot.h $(srcdir)/../lib/Opcodes.h

INCLUDES =  -I$(srcdir)/../lib @X_CFLAGS@

LDADD = @X_LIBS@ -lXt @X_PRE_LIBS@ -lX11 @X_EXTRA_LIBS@
