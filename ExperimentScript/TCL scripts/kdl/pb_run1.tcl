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
	
	
set spd 0.5
broadcast $spd
#oct softlowerlim -1.5
#oct softupperlim 1.5
#set oct_cycles 1
som speed $spd
som accel $spd
som maxretry 0
drive som 0.5


title Ge115 in plane 90 degree scan
sampledescription Ge wafer
samplename
sampletitle

user ajs
email ajs@ansto.gov.au

hold 1
