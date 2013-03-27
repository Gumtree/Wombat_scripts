or# proc to set up rad coll

proc ::histogram_memory::pre_count {} {
#        global oct_cycles
        oscmd start 2
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
	
set spd [expr 4.0/60.0]
broadcast $spd
oct softlowerlim -1.5
oct softupperlim 1.5
#set oct_cycles 1
oct speed $spd
oct accel $spd
oct maxretry 0
drive oct 1.0


title background
sampledescription 110/1.78
samplename background
sampletitle
#CollScan3D som 24 0.2 18
SimpleRun 2

user ajs
email ajs@ansto.gov.au




# uncomment this to kill rad coll
proc ::histogram_memory::pre_count {} {}
