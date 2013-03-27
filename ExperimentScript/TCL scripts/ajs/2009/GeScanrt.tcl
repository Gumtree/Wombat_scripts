title Ge stack in parallel plane 115 

samplename mtth= 90 115 1.54A
user ajs
email ajs@ansto.gov.au

proc XYmove {Xmot Ymot} { 
	set xpos [expr int(-25000*$Xmot)]
	set ypos [expr int(-25000*$Ymot)]
	systr= "sy send PR`=$xpos"
	sphistr = "sphi send PR`=$ypos"
#	sy send PR`=$xpos
	eval systr
	sy send BG`
#	sphi send PR`=$ypos
	eval sphistr
	sphi send BG`
	SimpleScan som -1 0.1 10 5 
}

