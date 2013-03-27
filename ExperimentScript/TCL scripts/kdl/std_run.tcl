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


title sample in vac furnace test
sampledescription stick in furnace with sample
samplename none
sampletitle

user Jim Low / Wei Pang / ajs/ vkp
email ajs or vep@ansto.gov.au

hold 1

#tc1 ramprate 10000
#tc1 setpoint 0

#sampletitle heat to 1220
#rampup 1220 600
#sampletitle heat to 1270
#rampup 1270 180
#sampletitle hold 1hr
#hold 60
#sampletitle cool to 1000
#rampup 1000 600
#sampletitle cool to room temp
#tc1 ramprate 10000
#tc1 setpoint 0
#hold 60
#hold 60
#hold 60
#hold 60


# uncomment this to kill rad coll
proc ::histogram_memory::pre_count {} {}
