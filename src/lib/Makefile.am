## Process this file with automake to produce Makefile.in

## Do not require GNU tools
AUTOMAKE_OPTIONS = foreign no-dependencies

EXTRA_DIST = \
libdecode.mak \
libghost.mak \
libgrid.mak \
libgrid_decode.mak \
libgrid_hpgl2.mak \
libgrid_postcl.mak \
libgrid_postsc.mak \
libgrid_trenc.mak \
libgrid_xghost.mak \
libhpgl2.mak \
libpostcl.mak \
libpostsc.mak \
libtrand.mak \
libtrenc.mak \
libxghost.mak


lib_LTLIBRARIES = \
libdecode.la \
libghost.la \
libgrid.la \
libgrid_decode.la \
libgrid_hpgl2.la \
libgrid_postcl.la \
libgrid_postsc.la \
libgrid_trenc.la \
libgrid_xghost.la \
libhpgl2.la \
libpostcl.la \
libpostsc.la \
libtrand.la \
libtrenc.la \
libxghost.la

include $(srcdir)/libdecode.mak
include $(srcdir)/libghost.mak
include $(srcdir)/libgrid.mak
include $(srcdir)/libgrid_decode.mak
include $(srcdir)/libgrid_hpgl2.mak
include $(srcdir)/libgrid_postcl.mak
include $(srcdir)/libgrid_postsc.mak
include $(srcdir)/libgrid_trenc.mak
include $(srcdir)/libgrid_xghost.mak
include $(srcdir)/libhpgl2.mak
include $(srcdir)/libpostcl.mak
include $(srcdir)/libpostsc.mak
include $(srcdir)/libtrand.mak
include $(srcdir)/libtrenc.mak
include $(srcdir)/libxghost.mak

xgenieIF.o: xgenieIF.c xgenie.h Opcodes.h

AM_FFLAGS = -DGHOST_LIBDIR=\"@libdir@\" -DGHOST_LIBEXECDIR=\"@libexecdir@\"
AM_CPPFLAGS = -DGHOST_LIBDIR=\"@libdir@\" -DGHOST_LIBEXECDIR=\"@libexecdir@\"
