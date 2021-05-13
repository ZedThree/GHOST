Ghost 80
========

Ghost 80 is a Fortran package for making graphs. Originally written at
UKAEA in the 1980s, it is now essentially abandonware. Use at your own
risk. The licence is now MIT.

Ghost 80 is packaged following the GNU guidelines using
automake and autoconf.

## Installation

Ghost 80 needs a Fortran 77 compiler, and the X11 libraries.

Generic install instructions are in the file INSTALL.

Instructions for Windows NT/2000 are in READMENT.txt.

To get started quickly unpack the distribution and do
the following from the top level directory:

```bash
$ mkdir build && cd build
$ ../configure --prefix=<install directory>
$ make
$ make install
```

Notes:

1) To test GHOST you can run the demosurf program in src/bin
2) Libtool is used so that demosurf is actually a script which
invokes the real executable in the correct environment.
3) Only shared libraries are built by default.
4) The default install directory is /opt/culham. You may need to
add /opt/culham/lib to /etc/ld.conf on Linux (and run ldconfig) or 
link your applications  -R/opt/local/lib on Solaris.
5) You need a compiler which will preprocesses *.F files: SPARCompiler 
f77 5.0 works, some patch levels of SPARCompiler f77 4.2 did not work. 
g77 in gcc-2.95.2 works, g77 in some earlier egcs releases did not work.
6) automake-1.4p5 or later is required to regenerate Makefile.in files.


