# proc to set up rad coll

proc ::histogram_memory::pre_count {} {
#        global oct_cycles
#        oscmd start 1
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
	
	
#set spd [expr 4.0/60.0]
#broadcast $spd
#oct softlowerlim -1.5
#oct softupperlim 1.5
#set oct_cycles 1
#oct speed $spd
#oct accel $spd
#oct maxretry 0
#drive oct 1.0


#title 17-4 PH heat to 1360
#title quick test histogram setup
#sampledescription alumina with boroflex bits
#samplename al2o3
#user ajs
#email ajs@ansto.gov.au

#hold 1


# uncomment this to kill rad coll
#proc ::histogram_memory::pre_count {} {}
