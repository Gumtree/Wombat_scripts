# proc to set up rad coll

proc ::histogram_memory::pre_count {} {
#        global oct_cycles
        oscmd start 1
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

proc octtime {time} {
	set spd [expr 4.0/ $time]	
	broadcast $spd

	oct softlowerlim -1.5
	oct softupperlim 1.5

	oct speed $spd
	oct accel $spd
	oct maxretry 0
	drive oct 1.0
}	
	

title TiAl TNM ramp profile 1350/1450/1500
sampledescription Ti 43.9Al 4Nb 1Mo 
samplename virgin sample
sampletitle

user Watson/Liss
email ajs or iwa or kdl@ansto.gov.au

tc1 ramprate 10000
tc1 setpoint 0

octtime 10

sampletitle heat to 1350 C, 40 k/min
rampup 1350 2400 
sampletitle cool to 850 C, 40 k/min
rampup 850 2400

sampletitle heat to 1350 C, 40 k/min
rampup 1350 2400 
sampletitle cool to 850 C, 40 k/min
rampup 850 2400

sampletitle heat to 1350 C, 10 k/min
rampup 1350 600 
sampletitle cool to 850 C, 10 k/min
rampup 850 600

sampletitle heat to 1350 C, 3 k/min
rampup 1350 180 
sampletitle cool to 850 C, 3 k/min
rampup 850 180

sampletitle heat to 1450 C, 10 k/min
rampup 1450 600 
sampletitle cool to 850 C, 10 k/min
rampup 850 600

sampletitle heat to 1500 C, 20 k/min
rampup 1500 1200 
sampletitle cool to 850 C, 20 k/min
rampup 850 1200

tc1 ramprate 10000
tc1 setpoint 0

sampletitle hold after shutdown
hold 60
hold 60




# uncomment this to kill rad coll
proc ::histogram_memory::pre_count {} {}
