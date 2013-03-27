# proc to set up rad coll

proc ::histogram_memory::pre_count {} {
#        global oct_cycles
        sommd start 1
}



proc hold {time} {
	set tim1 [clock seconds]
	set bool 0
	histmem mode unlimited
	newfile HISTOGRAM_XY	

	set i 0
	while {$bool==0} {
		histmem start block
		save $i
		incr i
		set tim2 [expr [clock seconds]-$tim1]
		if {$tim2>$time*60} {set bool 1}
	}
}	

som softupperlim 45.5
som softlowerlim -45.5

sphi send SH`
sy send SH`	
	
set spd 1
broadcast $spd
#oct softlowerlim -1.5
#oct softupperlim 1.5
#set oct_cycles 1
som speed $spd
som accel $spd
som maxretry 0
drive som 45.5


title Ge scan omega 90 degrees in plane -/
sampledescription Ge wafer stack
samplename
sampletitle mtth=90 115 1.54A wide slit

user ajs
email ajs@ansto.gov.au

hold 1

sphi send MO`
sy send MO`	

# uncomment this to kill rad coll
proc ::histogram_memory::pre_count {} {}
