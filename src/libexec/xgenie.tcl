#! /bin/sh
# \
exec wish8.0 -f "$0" ${1+"$@"}

# %W% AEA GHOST %G%

# TCL/TK 8.0 replacement for xgenie

# default options

set name "xgenie.tcl"

# read database
set width [option get . gWidth GWidth]
set height [option get . gHeight GHeight]
set xor [option get . gXor GXor]
set yor [option get . gYor GYor]

set state name

# process arguments
foreach arg $argv {
    if { [string match -* $arg] } {set state flag }
    switch -- $state {
	name { set name $arg; set state flag }
	flag {
	    switch -- $arg {
		-gwid {set state width}
		-ght  {set state height}
		-gxor {set state xor}
		-gyor {set state yor}
	    }
	}
	width { set width $arg; set state name }
	height { set height $arg; set state name }
	xor { set xor $arg; set state name }
	yor { set yor $arg; set state name }
    }
}

if { "$width" == ""  }  {set width 800}
if { "$height" == "" }  {set height 600}
if { "$xor" == "" }     {set xor 0}
if { "$yor" == "" }     {set yor 0}
if { "$name" == "" }    {set name {}}

# set name and origin
wm title . $name
wm geometry . [format "%ix%i%+i%+i" $width $height $xor $yor]

# configure i/o 
fconfigure stdin  -translation binary -buffering none
fconfigure stdout -translation binary

# create canvas to plot on
set canvas [canvas .c -background black -width $width -height $height]
pack $canvas -expand true
$canvas config -cursor cross
tkwait visibility $canvas

# set initial properties
set depth [winfo depth $canvas]
set w $width
set h $height
set scale 1.0
if { $height < $width } { 
    set rmul [expr $height/16384.0] 
} else {
    set rmul [expr $width/16384.0] 
}


# add callbacks
bind $canvas <Configure> Configure
bind $canvas <Destroy> exit

# define default backgound colour
set ctbl(0) black
set colour black
set icol 0
set continue 1

# select byte order
if { $tcl_platform(byteOrder) == "bigEndian" } {
    set I I
} else {
    set I i
}

# send back window properties
set windowsize [binary format $I$I$I$I 0 16383 16383 $depth]
puts -nonewline $windowsize
flush stdout

# setup input event loop
fileevent stdin readable Reader

# command reader
proc Reader {} {
    set OP_POLYLINE   [expr 0x2001]
    set OP_POLYMARK   [expr 0x2002]
    set OP_FILLPOLY   [expr 0x2003]
    set OP_TEXT       [expr 0x2004]
    set OP_SETFC      [expr 0x2005]
    set OP_FLUSH      [expr 0x2006]
    set OP_GETIN      [expr 0x2007]
    set OP_COLTB      [expr 0x2008]
    set OP_ERASE      [expr 0x2009]
    set OP_DEFIMAGE   [expr 0x200a]
    set OP_PUTIMAGE   [expr 0x200b]
    set OP_DUMPBUFFER [expr 0x200c]
    set OP_QUIT       [expr -1]
    
    global I
    binary scan [read stdin 4] $I command
    if [eof stdin] exit
    switch -- $command \
	$OP_POLYLINE PolyLine\
	$OP_POLYMARK PolyMark\
	$OP_FILLPOLY FillPoly\
	$OP_TEXT     Text\
	$OP_SETFC    SetFC\
	$OP_FLUSH    Flush\
	$OP_GETIN    GetIn\
	$OP_COLTB    ColTB\
	$OP_ERASE    Erase\
	$OP_QUIT     Quit
}

# add/change colour table entry
proc ColTB {} {
    global ctbl
    global canvas
    global I
    binary scan [read stdin 16] $I$I$I$I i r g b
    set ctbl($i) [format "#%02x%02x%02x" $r $g $b]
    $canvas itemconfigure  col$i -fill  $ctbl($i)  -outline  $ctbl($i)  
    if { $i == 0 } {
	$canvas configure -background $ctbl($i)
    }
}

# set foreground colour
proc SetFC {} {
    global icol
    global I
    binary scan [read stdin 4] $I icol
    global ctbl
    global colour
    set colour $ctbl($icol)
}

# draw polyline
proc PolyLine {} {
    global canvas
    global rmul
    global I
    binary scan [read stdin 4] $I npoints
    for {set i 0} {$i < $npoints} {incr i} {
	binary scan [read stdin 4] $I x($i)
    }
    for {set i 0} {$i < $npoints} {incr i} {
	binary scan [read stdin 4] $I y($i)
    }
    set cmd [list $canvas create line]
    global h
    for {set i 0} {$i < $npoints} {incr i} {
	lappend cmd [expr $x($i)*$rmul] [expr $h-$y($i)*$rmul]
    }
    global colour
    global icol
    lappend cmd -fill $colour -width 0 -tag all -tag col$icol
    eval $cmd
    update idletasks
}

# draw ploymark
proc PolyMark {} {
    global canvas
    global rmul
    global I
    binary scan [read stdin 4] $I npoints
    for {set i 0} {$i < $npoints} {incr i} {
	binary scan [read stdin 4] $I x($i)
    }
    for {set i 0} {$i < $npoints} {incr i} {
	binary scan [read stdin 4] $I y($i)
    }
    global colour
    global icol
    global h
    for {set i 0} {$i < $npoints} {incr i} {
	set xp $x($i)
	set yp $y($i)
	set cmd [list $canvas create rect]
	lappend cmd [expr ($xp-0.5)*$rmul] [expr $h-($yp-0.5)*$rmul] 
	lappend cmd [expr ($xp+0.5)*$rmul] [expr $h-($yp+0.5)*$rmul]
	lappend cmd -fill $colour -outline $colour -tag all -tag col$icol
	eval $cmd
    }
    update idletasks
}

# fill polygon
proc FillPoly {} {
    global canvas
    global rmul
    global I
    binary scan [read stdin 4] $I npoints
    for {set i 0} {$i < $npoints} {incr i} {
	binary scan [read stdin 4] $I x($i)
    }
    for {set i 0} {$i < $npoints} {incr i} {
	binary scan [read stdin 4] $I y($i)
    }
    set cmd [list $canvas create poly]
    global h
    for {set i 0} {$i < $npoints} {incr i} {
	lappend cmd [expr $x($i)*$rmul] [expr $h-$y($i)*$rmul]
    }
    global colour
    global icol
    lappend cmd -fill $colour -tag all -tag col$icol
    eval $cmd
    update idletasks
}

# plot text
proc Text {} {
    global I
    binary scan [read stdin 10] $I$Icc x y c z
    eval {$canvas create text} $x $y -text $c {-fill $colour -tag all -tag col$icol}
    puts stderr "text x, y = $x, $y, char = $c"
}

# get mouse or keyboard input
proc GetIn {} {
    update idletasks
    global canvas
    bind $canvas <Button> { BPress %b %x %y ; break}
    bind $canvas <KeyPress> { KPress %A %x %y ; break}
    global continue
    set continue 0
    focus $canvas
    bell
    $canvas config -cursor crosshair
    tkwait variable continue
    bind $canvas <Button> {}
    bind $canvas <KeyPress> {}
    $canvas config -cursor cross
    update idletasks
}

# update graphics
proc Flush {} {
    global I
    update idletasks
    puts -nonewline [binary format $I 0]
    flush stdout
}

# finish
proc Quit {} {
    exit
}

# clear screen
proc Erase {} {
    global canvas
    global ctbl
    global w
    global h
    $canvas delete all
    update idletasks
}


# resize
proc Configure {} {
    global width
    global height
    global canvas
    global w
    global h
    global scale
    global rmul
    set w [winfo width .]
    set h [winfo height .]
    set w [expr $w-2.0]
    set h [expr $h-2.0]
    $canvas configure -width $w
    $canvas configure -height $h
    if { $w < $h } { set n $w } else {set n $h}
    if { $width < $height } { set o $width } else {set o $height}
    set os $scale
    set scale [expr $n/$o]
    set rmul [expr $rmul*$scale/$os]
    $canvas scale all 0 0 [expr $scale/$os] [expr $scale/$os]
    update idletasks
}

# process button press
proc BPress { b x y } {
    global h
    global w
    global rmul
    global continue
    global I
    set continue 1
    puts -nonewline [binary format $I$I$I$I$I 1 $b 0 [expr int($x/$rmul)] [expr int(($h-$y)/$rmul)] ]
    flush stdout
}

# process key press
proc KPress { a x y } {
    global h
    global w
    global rmul
    global continue
    global I
    set continue 1
    set ia 0
    binary scan $a c ia
    puts -nonewline [binary format $I$I$I$I$I 2 0 $ia [expr int($x/$rmul)] [expr int(($h-$y)/$rmul)] ]
    flush stdout
}
