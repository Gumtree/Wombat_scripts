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
	
	
set spd [expr 4.0/60.0]
broadcast $spd
oct softlowerlim -1.5
oct softupperlim 1.5
#set oct_cycles 1
oct speed $spd
oct accel $spd
oct maxretry 0
drive oct 1.0


title Cr2AlC run 3 full protocol
sampledescription Cr2AlC solid cylinder
samplename none
sampletitle

user Jim Low / Wei Pang / ajs/ vkp
email ajs or vep@ansto.gov.au



tc1 ramprate 10000
tc1 setpoint 0

# short hold points

sampletitle heat to 1000 at 10deg/min
rampup 1000 600
sampletitle hold at 1000 for 30min
hold 30

sampletitle heat to 1100 at 5deg/min
rampup 1100 300
sampletitle hold at 1100 for 30min
hold 30

sampletitle heat to 1200 at 5deg/min
rampup 1200 300
sampletitle hold at 1200 for 30min
hold 30

sampletitle heat to 1300 at 5deg/min
rampup 1300 300
sampletitle hold at 1300 for 30min
hold 30

# long hold points

sampletitle heat to 1400 at 5deg/min
rampup 1400 300
sampletitle hold at 1400 for 200min
hold 200

sampletitle heat to 1450 at 5deg/min
rampup 1450 300
sampletitle hold at 1450 for 200min
hold 200

sampletitle heat to 1500 at 5deg/min
rampup 1500 300
sampletitle hold at 1500 for 200min
hold 200

sampletitle heat to 1550 at 5deg/min
rampup 1550 300
sampletitle hold at 1550 for 200min
hold 200

# cool down to rt

sampletitle cool to 500 at 10deg/min
rampup 500 600
sampletitle cool to RT

tc1 ramprate 10000
tc1 setpoint 0

hold 60
hold 60
hold 60




# uncomment this to kill rad coll
proc ::histogram_memory::pre_count {} {}
