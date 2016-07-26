## Process this file with automake to produce Makefile.in

## Do not require GNU tools
AUTOMAKE_OPTIONS = foreign no-dependencies

noinst_PROGRAMS = build

build_SOURCES = build.F

ghostfonts = \
GHOST80FONT11 \
GHOST80FONT12 \
GHOST80FONT13 \
GHOST80FONT14 \
GHOST80FONT15 \
GHOST80FONT16 \
GHOST80FONT17 \
GHOST80FONT18 \
GHOST80FONT19 \
GHOST80FONT20 \
GHOST80FONT21 \
GHOST80FONT22 \
GHOST80FONT23 \
GHOST80FONT24 \
GHOST80FONT25

psfonts = \
GHOST80FNT101 \
GHOST80FNT102 \
GHOST80FNT103 \
GHOST80FNT104 \
GHOST80FNT105 \
GHOST80FNT106 \
GHOST80FNT107 \
GHOST80FNT108 \
GHOST80FNT109 \
GHOST80FNT110 \
GHOST80FNT111 \
GHOST80FNT112 \
GHOST80FNT113

EXTRA_DIST = HERSHY.DAT COMFIN.DAT $(psfonts)

all-local: $(ghostfonts)

$(ghostfonts) : $(srcdir)/HERSHY.DAT $(srcdir)/COMFIN.DAT
	rm -f $(ghostfonts)
	if test  ! "$(srcdir)" = "." ; then \
	  rm -f HERSHY.DAT COMFIN.DAT; \
	  cp $(srcdir)/HERSHY.DAT $(srcdir)/COMFIN.DAT . ; \
	fi
	./build

install-exec-local:
	$(mkinstalldirs) $(libdir)/fonts
	for i in $(ghostfonts); do \
	  $(INSTALL_DATA) $$i $(libdir)/fonts/$$i ;\
	done
	for i in $(psfonts); do \
	  $(INSTALL_DATA) $(srcdir)/$$i $(libdir)/fonts/$$i ;\
	done

uninstall-local:
	for i in $(ghostfonts); do \
	  rm -f $(libdir)/fonts/$$i ;\
	done
	for i in $(psfonts); do \
	  rm -f $(libdir)/fonts/$$i ;\
	done
	rmdir $(libdir)/fonts

clean-local:
	rm -f $(ghostfonts)
