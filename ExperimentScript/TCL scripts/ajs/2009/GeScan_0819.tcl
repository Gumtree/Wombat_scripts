{title Ge stack in parallel plane 115 

samplename mtth= 90 115 1.54A
user ajs
email ajs@ansto.gov.au

proc XYrelmove {Xmot Ymot} { 
	set xpos [expr int(-25000*$Xmot)]
	set ypos [expr int(-25000*$Ymot)]
	systr = "sy send PR`=$xpos"
	sphistr = "sphi send PR`=$ypos"
#	sy send PR`=$xpos
	eval systr
	sy send BG`
#	sphi send PR`=$ypos
	eval sphistr
	sphi send BG`
	SimpleScan som -1 0.1 10 5 
}


# top layer (3 points)
sampletitle x=-1 y=3
XYrelmove -1 3

sampletitle x=0 y=3
XYrelmove 1 0

sampletitle x=1 y=3
XYrelmove 1 0

# 2nd layer (5 points)

sampletitle x=-2 y=2)
XYrelmove  -3 -1

sampletitle x=-1 y=2
XYrelmove 1 0

sampletitle x=0 y=2
XYrelmove 1 0

sampletitle x=1 y=2
XYrelmove 1 0
sampletitle x=2 y=2
XYrelmove 1 0

# 3rd layer (7 points)

sampletitle x=-3 y=1
XYrelmove -5 -1

sampletitle x=-2 y=1
XYrelmove 1 0

sampletitle x=-1 y=1
XYrelmove 1 0

sampletitle x=-0 y=1
XYrelmove 1 0

sampletitle x=1 y=1
XYrelmove 1 0

sampletitle x=2 y=1
XYrelmove 1 0

# 4th layer (7 points)

sampletitle x=-3 y=0
XYrelmove -6 -1

sampletitle x=-2 y=0
XYrelmove 1 0

sampletitle x=-1 y=0
XYrelmove 1 0

sampletitle x=-0 y=0
XYrelmove 1 0

sampletitle x=1 y=0
XYrelmove 1 0

sampletitle x=2 y=0
XYrelmove 1 0


