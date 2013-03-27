# proc to set up rad coll

proc ::histogram_memory::pre_count {} {
#        global oct_cycles
#        oscmd start 1
}

proc CollAxisScan {motor start step numsteps} {


#	set spd [expr 4.0/60.0]
#	broadcast $spd
#	oct softlowerlim -1.5
#	oct softupperlim 1.5
#	oct speed $spd
#	oct maxretry 0
#	drive oct 1.0
#	broadcast $som

	newfile HISTOGRAM_XY
	for {set i 0} {$i <$numsteps} {incr i} {
		drive $motor [expr $i*$step+$start]
		histmem start block
		save $i
	}
}	

histmem mode time
histmem preset 40
title CaTiO3 O-18 T 3K scan 0kl
sampletitle CaTiO3 O-18 single xtal
samplename CaTiO3 O-18
user ajs
email ajs@ansto.gov.au

CollAxisScan som -60 0.1 200
CollAxisScan som -40 0.1 200
CollAxisScan som -20 0.1 200
CollAxisScan som 0 0.1 200
CollAxisScan som 20 0.1 200
CollAxisScan som 40 0.1 200
CollAxisScan som 60 0.1 200


title CaTiO3 O-18 T 30K scan 0kl
histmem preset 40
tc1 settle 600
drive tc1 30

CollAxisScan som  -60 0.1 200
CollAxisScan som  -40 0.1 200
CollAxisScan som  -20 0.1 200
CollAxisScan som  00 0.1 200
CollAxisScan som  20 0.1 200
CollAxisScan som  40 0.1 200
CollAxisScan som  60 0.1 200

drive tc1 300

# uncomment this to kill rad coll
proc ::histogram_memory::pre_count {} {}
