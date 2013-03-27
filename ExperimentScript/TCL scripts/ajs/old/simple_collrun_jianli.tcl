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
		broadcast $tim2
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

octtime 60

title test fridge behaviour for J Wang
sampletitle none
samplename none (test run)
user ajs / jianli wang
email ajs@ansto.gov.au

#cool fridge for 8 hours
wait 28800

# this had better not block
tc1 tolerance 400
tc2 tolerance 400
tc1 settle 0
tc2 settle 0

sampletitle ramp 100
run tc1 100
run tc2 100
hold 100

sampletitle hold 10 mins at 100
hold 10

sampletitle ramp 200
run tc1 200
run tc2 200
hold 100

sampletitle hold 10 mins at 200
hold 10

sampletitle ramp 300
run tc1 300
run tc2 300
hold 100

sampletitle hold 10 mins at 300
hold 10

sampletitle ramp 400
run tc1 400
run tc2 400
hold 100

sampletitle hold 10 mins at 400
hold 10

sampletitle ramp

run tc1 450
run tc2 450
hold 50

sampletitle hold 10 mins at 450
hold 10


# uncomment this to kill rad coll
proc ::histogram_memory::pre_count {} {}
