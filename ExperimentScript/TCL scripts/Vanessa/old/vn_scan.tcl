# proc to set up rad coll

proc ::histogram_memory::pre_count {} {
#        global oct_cycles
        oscmd start 1
}

proc CollScan3D {motor start step numsteps} {
	
	histmem mode unlimited
#	histmem preset $steptime
	newfile HISTOGRAM_XY	
	for {set i 0} {$i <$numsteps} {incr i} {
		drive $motor [expr $i*$step+$start]
		histmem start block
	save $i
	}
}
	
set spd [expr 4.0/60.0]
broadcast $spd
oct softlowerlim -1.5
oct softupperlim 1.5
#set oct_cycles 1
oct speed $spd
oct accel $spd
oct maxretry 0
drive oct 1.0


title Vn scan with 2theta steps 2.41A
sampledescription Vn hollow tube
samplename Vn
user ajs
email ajs@ansto.gov.au
CollScan3D stth 15 0.02 300

#alternatively sphi? by -10

title bcg for Vn at 2.41A
sampledescription none
samplename none
drive sy -15
#alternatively sphi? by -10

CollScan3D stth 15 0.02 300

# uncomment this to kill rad coll
proc ::histogram_memory::pre_count {} {}
