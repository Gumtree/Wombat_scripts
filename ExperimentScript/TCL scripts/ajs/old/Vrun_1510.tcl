user "ajs"
email "ajs@ansto.gov.au"
phone "3602"
proc ::histogram_memory::pre_count {} {
#       global oct_cycles
        oscmd start 1
}

proc SimpleRun {numsteps} {
#	histmem mode time
    histmem mode unlimited 
	newfile HISTOGRAM_XY
#	histmem preset $steptime
	for {set i 0} {$i < $numsteps} {incr i} {
		histmem start block
		save $i
	}
}

proc Scan3D {motor start step numsteps} {
	
#	histmem mode time
#	histmem preset $steptime
	histmem mode unlimited
	newfile HISTOGRAM_XY	
	for {set i 0} {$i <$numsteps} {incr i} {
		drive $motor [expr $i*$step+$start]
		histmem start block
	save $i
	}
}

set spd [expr 4.0/60.0]
oct softlowerlim -1.5
oct softupperlim 1.5
set oct_cycles 1
oct speed $spd
oct accel $spd
oct maxretry 0
drive oct 1.0

# first 1.83A

drive mtth 65
drive mom 40.9
drive mf2 0.5

title Vanadium 1.83A 65/113 rad coll 
samplename V
sampletitle V
sampledescription V

drive sy 0
Scan3D stth 15 0.05 300

title bcg for Vanadium 1.83A 65/113 rad coll
samplename none
sampletitle none
sampledescription none

drive sy -18
Scan3D stth 15 0.05 300

# now for 1.5A

drive mtth 55
drive mom 35.9

title Vanadium 1.5A 55/113 rad coll 
samplename V
sampletitle V
sampledescription V

drive sy 0
Scan3D stth 15 0.05 150

title bcg for Vanadium 1.5A 55/113 rad coll
samplename none
sampletitle none
sampledescription none

drive sy -18
Scan3D stth 15 0.05 150

drive sy 0


proc ::histogram_memory::pre_count {} {}




