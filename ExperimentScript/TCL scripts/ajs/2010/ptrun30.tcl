

title Run30 - 300oC 15min hold H2PtCl6
sampledescription H2PtCl6 hold at 300oC fro 15min 
samplename H2PtCl6 300oC 15min hold
sampletitle H2PtCl6 300oC 15min hold
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
	
proc RadCollRamp {start step fin oscno} {
					
	histmem mode unlimited	
	newfile HISTOGRAM_XY
	set loopvar 1
	set i 0 
	while {$loopvar} {
		set j [expr {$i*$step+$start}]
		if {$j>= $fin && $step > 0} {break}
		if {$j<= $fin && $step < 0} {break}
		drive tc1_driveable $j tc1_driveable2 $j
		oscmd start $oscno
		hmm countblock
		save $i			
		incr i		
	}
	oscmd stop
	
}

hset /sample/tc1/control/ramp_Loop_1 0,2.2
hset /sample/tc1/control/ramp_Loop_2 0,2.2
hset /sample/tc1/sensor/setpoint1 573
hset /sample/tc1/sensor/setpoint2 573
hset /sample/tc1/control/ramp_Loop_1 1,2.2
hset /sample/tc1/control/ramp_Loop_2 1,2.2

RunT 573 0 3 5 
				