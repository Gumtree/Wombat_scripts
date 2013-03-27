# proc to set up rad coll

proc ::histogram_memory::pre_count {} {
        global oct_cycles
        oscmd start $oct_cycles
}

proc rampup {temp rate} {
	set tstart [SplitReply [tc1 setpoint]]
	set tim1 [clock seconds]
	set tlength [expr abs($tstart-$temp)/($rate/3600.0)]
	broadcast $tstart
	broadcast $temp
	broadcast $rate
	broadcast $tlength 
	tc1 ramprate $rate
	tc1 setpoint $temp
	broadcast $rate $temp 
	set bool 0
	set i 0
	histmem mode unlimited
	newfile HISTOGRAM_XY	
	set oct_cycles 1
	while {$bool==0} {
		histmem start block
		save $i
		incr i
		set tim2 [expr [clock seconds]-$tim1]
		broadcast $tim2 $tlength
		if {$tim2>$tlength} {bool=1}
	}
}

proc hold {time} {
	set tim1 [clock seconds]
	set bool 0
	histmem mode unlimited
	newfile HISTOGRAM_XY	
	set oct_cycles 1
	set i 0
	while {$bool==0} {
		histmem start block
		save $i
		incr i
		set tim2 [expr [clock seconds]-$tim1]
		if {$tim2>$time*60} {bool=1}
	}
}	
	
	
set spd [expr 4.0/30.0]
broadcast $spd
oct softlowerlim -1.5
oct softupperlim 1.5

oct speed $spd
oct accel $spd
oct maxretry 0
drive oct 1.0


title test vac furnace ramp with sample
sampledescription pre-sintered steel
samplename 17-4 PH
sampletitle furnace with sample test ramp command

user Ross Whitfield / Darren Goossens / ajs
email u4133815@anu.edu.au
#tc1 ramprate 10000
#tc1 setpoint 100

#rampup 0 1250
hold 5
#hold 5
#rampup 0 600


# uncomment this to kill rad coll
proc ::histogram_memory::pre_count {} {}
