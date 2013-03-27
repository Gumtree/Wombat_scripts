# proc to set up rad coll

proc ::histogram_memory::pre_count {} {
#        global oct_cycles
        sommd start 1
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
		if {$tim2>$tlength} {set bool 1}
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
		if {$tim2>$time*60} {set bool 1}
	}
}	

som softupperlim 0.5
som softlowerlim -20.5
	
	
set spd 1
broadcast $spd
#oct softlowerlim -1.5
#oct softupperlim 1.5
#set oct_cycles 1
som speed $spd
som accel $spd
som maxretry 0
drive som 0.5


title Al alloy run 2 ramp 680 cool 1deg/min
sampledescription Al alloy B1009 (270504) 0.2 Fe
samplename
sampletitle

user Bendeich/Easton/kdl/ajs
email ajs or pbx@ansto.gov.au

tc1 ramprate 10000
tc1 setpoint 0

sampletitle heat to 600
rampup 600 600 
sampletitle hold at 600 for 10 min
hold 10
sampletitle heat to 680
rampup 680 600
sampletitle hold at 680 for 15 min
hold 15
sampletitle cool to 540 at 1deg/min
rampup 540 60

# shut down furnace

tc1 ramprate 10000
tc1 setpoint 0

sampletitle hold after shutdown
hold 60


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
