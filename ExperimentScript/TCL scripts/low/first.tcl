
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

setradcoll 60 2
ResetWest	

title Ti3SiC2 run 1 
sampledescription Ti3SiC2 run 1 
samplename Ti3SiC2 run 1

user Jim Low / Wei Pang / ajs/ vkp
email ajs or vep@ansto.gov.au

tc1 ramprate 10000
tc1 setpoint 0

# short hold points

sampletitle hold at 150 for 5min
hold 5

sampletitle heat to 1100 at 10deg/min
rampup 1100 600
sampletitle hold at 1100 for 50min
hold 50

sampletitle heat to 1200 at 10deg/min
rampup 1200 600
sampletitle hold at 1200 for 100min
hold 100

sampletitle heat to 1300 at 10deg/min
rampup 1300 600
sampletitle hold at 1300 for 100min
hold 100

sampletitle heat to 1400 at 10deg/min
rampup 1400 600
sampletitle hold at 1400 for 100min
hold 100

sampletitle heat to 1500 at 10deg/min
rampup 1500 600
sampletitle hold at 1500 for 100min
hold 100

# cool down to rt

sampletitle cool to 500 at 10deg/min
rampup 500 600
sampletitle cool to RT

tc1 ramprate 10000
tc1 setpoint 0

hold 60
hold 60
hold 60
hold 60
hold 60
hold 60




# uncomment this to kill rad coll
proc ::histogram_memory::pre_count {} {}
