

title Run36 - 1 hour hold at 440oC
sampledescription 5min scan at every 5min for 1 hour H2PtCl6
samplename 5min scan at every 5min for 1 hour H2PtCl6
sampletitle 5min scan at every 5min for 1 hour H2PtCl6
user Perkins / Smith / Studer
email gary.perkins@ansto.gov.au

SetRadColl 60 2

proc RunT {temp delay numsteps oscno} {
#	hset /sample/tc1/sensor/setpoint1 $temp
#	hset /sample/tc1/sensor/setpoint2 $temp

	drive tc1_driveable $temp tc1_driveable2 $temp 
	wait $delay
	newfile HISTOGRAM_XY
	for {set i 0} {$i < $numsteps} {incr i} {	
		oscmd start $oscno
		hmm countblock
		save $i
	}
}

proc RunStep {start step fin delay oscno} {
#	hset /sample/tc1/sensor/setpoint1 $temp
#	hset /sample/tc1/sensor/setpoint2 $temp

	histmem mode unlimited	
	newfile HISTOGRAM_XY
	set loopvar 1
	set i 0
	while ($loopvar) {
		set k [expr {$i*$step+$start}]
		if {$k> $fin && $step > 0} {break}
		if {$k< $fin && $step < 0} {break}
		drive tc1_driveable $k tc1_driveable2 $k 
		wait $delay
		
		oscmd start $oscno
		hmm countblock
		save $i
		incr i
	}
	oscmd stop
}

proc RadCollRamp {start step fin oscno} {
					
	histmem mode unlimited	
	newfile HISTOGRAM_XY
	set loopvar 1
	set i 0 
	while {$loopvar} {
		set j [expr {$i*$step+$start}]
		if {$j> $fin && $step > 0} {break}
		if {$j< $fin && $step < 0} {break}
		drive tc1_driveable $j tc1_driveable2 $j
		oscmd start $oscno
		hmm countblock
		save $i			
		incr i		
	}
	oscmd stop
	
}

hset /sample/tc1/control/ramp_Loop_1 0,2.5
hset /sample/tc1/control/ramp_Loop_2 0,2.5
hset /sample/tc1/sensor/setpoint1 713
hset /sample/tc1/sensor/setpoint2 713
hset /sample/tc1/control/ramp_Loop_1 1,2.5
hset /sample/tc1/control/ramp_Loop_2 1,2.5

RunT 713 0 12 5

hset /sample/tc1/control/ramp_Loop_1 0,2.2
hset /sample/tc1/control/ramp_Loop_2 0,2.2
hset /sample/tc1/sensor/setpoint1 297
hset /sample/tc1/sensor/setpoint2 297
hset /sample/tc1/control/ramp_Loop_1 1,2.2
hset /sample/tc1/control/ramp_Loop_2 1,2.2