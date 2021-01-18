## Process this file with automake to produce Makefile.in

## Do not require GNU tools
AUTOMAKE_OPTIONS = foreign no-dependencies

bin_PROGRAMS = decode hpgl2 postcl postsc trand trenc xghost

noinst_PROGRAMS = demosurf

decode_SOURCES = interpcalla.f interpb.f g5jusl.f g5jusr.f
hpgl2_SOURCES  = interpcalla.f interpa.f g5jusl.f g5jusr.f
postcl_SOURCES = interpcalla.f interpa.f g5jusl.f g5jusr.f
postsc_SOURCES = interpcalla.f interpa.f g5jusl.f g5jusr.f
trand_SOURCES  = trandcalla.f trand.f
trenc_SOURCES  = interpcalla.f interpb.f
xghost_SOURCES = interpcalla.f interpc.f g5jusl.f g5jusr.f

demosurf_SOURCES = demosurf.f

decode_LDADD = ../lib/libghost.la ../lib/libgrid_decode.la
hpgl2_LDADD = ../lib/libghost.la ../lib/libgrid_hpgl2.la
postcl_LDADD = ../lib/libghost.la ../lib/libgrid_postcl.la
postsc_LDADD = ../lib/libghost.la ../lib/libgrid_postsc.la
trand_LDADD = ../lib/libtrand.la ../lib/libgrid.la
trenc_LDADD = ../lib/libghost.la ../lib/libgrid_trenc.la
xghost_LDADD = ../lib/libghost.la ../lib/libgrid_xghost.la

demosurf_LDADD = ../lib/libghost.la ../lib/libgrid_xghost.la

DEPLIBS = \
../lib/libghost.la \
../lib/libgrid_decode.la \
../lib/libgrid_hpgl2.la \
../lib/libgrid_postcl.la \
../lib/libgrid_postsc.la \
../lib/libgrid.la \
../lib/libgrid_trenc.la \
../lib/libgrid_xghost.la

$(DEPLIBS):
	cd $(@D); $(MAKE) $(@F)
