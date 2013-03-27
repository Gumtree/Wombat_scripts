# proc to set up rad coll

proc ::histogram_memory::pre_count {} {
#        global oct_cycles
        oscmd start 1
}



proc hold {time} {
	set tim1 [clock seconds]
	set bool 0
	histmem mode unlimited
	newfile HISTOGRAM_XY scratch	

	set i 0
	while {$bool==0} {
		histmem start block
		save $i
		incr i
		set tim2 [expr [clock seconds]-$tim1]
		broadcast $tim2
		if {$tim2>$time*60} {bool=1}
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
#drive oct 1.0


#title 17-4 PH heat to 1360
title test oct
sampletitle 
samplename 
user ajs
email ajs@ansto.gov.au

hold 60


# uncomment this to kill rad coll
proc ::histogram_memory::pre_count {} {}
