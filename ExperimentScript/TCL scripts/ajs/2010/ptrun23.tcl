

title Run25 - initial ramp 24oC to 90oC 5oC/min PtCl4+PtCl2
sampledescription initial ramp PtCl4+PtCl2 ramp to 250oC
samplename ramp to 100C for 100->250C run 5/min PtCl4+PtCl2
sampletitle initial ramp for PtCl4+PtCl2 ramp to 250oC increase 2.5/min
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

hset /sample/tc1/control/ramp_Loop_1 0,5.2
hset /sample/tc1/control/ramp_Loop_2 0,5.2
hset /sample/tc1/sensor/setpoint1 297
hset /sample/tc1/sensor/setpoint2 297
hset /sample/tc1/control/ramp_Loop_1 1,5.2
hset /sample/tc1/control/ramp_Loop_2 1,5.2

RadCollRamp 297 5 363 1

hset /sample/tc1/control/ramp_Loop_1 1,2.5
hset /sample/tc1/control/ramp_Loop_2 1,2.5

title Run26 - initial ramp start 90oC end 100oC increase 2.5/min PtCl4+PtCl2
RadCollRamp 363 2.5 373 1

title Run27 - 100oC to 250oC increase 2.5/min then 5 min run PtCl4+PtCl2
sampledescription PtCl4+PtCl2 ramp to 250oC
samplename PtCl4+PtCl2 ramp 100oC to 250oC increase 2.5/min
sampletitle PtCl4+PtCl2 ramp 100oC to 250oC increase 2.5/min
RunStep 373 5 523 120 5