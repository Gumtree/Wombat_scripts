# proc to set up rad coll

proc ::histogram_memory::pre_count {} {
#        global oct_cycles
        oscmd start 5
}
proc CollAxisScan {motor start step numsteps} {

	histmem mode unlimited
	set spd [expr 4.0/60.0]
	broadcast $spd
	oct softlowerlim -1.5
	oct softupperlim 1.5
	oct speed $spd
	oct accel $spd
	oct maxretry 0
	drive oct 1.0

	newfile HISTOGRAM_XY
	for {set i 0} {$i <$numsteps} {incr i} {
		drive $motor [expr $i*$step+$start]
		histmem start block
		save $i
	}
}	

title Co-Cu multilayer 27-10 rt scan attempt
sampledescription Co-Cu multilayer on Si wafer 3x20mm
samplename Co-Cu multilayer
user ajs
email ajs@ansto.gov.au

CollAxisScan som 22 0.2 15

# uncomment this to kill rad coll
proc ::histogram_memory::pre_count {} {}
