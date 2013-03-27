

title Run5 - 50oC 30min hold H2PtCl6
sampledescription H2PtCl6 ramp to 50oC
samplename H2PtCl6 50oC 30min hold
sampletitle H2PtCl6 50oC 30min hold
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

RadCollRamp 298 2 324 1
RunT 324 0 30 1
RunT 324 0 1 5 
				