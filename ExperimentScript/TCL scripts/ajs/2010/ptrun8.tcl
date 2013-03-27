

title Run8 - 52oC start increase 2/min 5 times H2PtCl6
sampledescription H2PtCl6 ramp to 60oC
samplename H2PtCl6 52oC start increase 2/min
sampletitle H2PtCl6 52oC start increase 2/min
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

RadCollRamp 326 2 334 1

title Run9 - 60oC 5min hold H2PtCl6
sampledescription H2PtCl6 at 60oC
samplename H2PtCl6 60oC hold 5min
sampletitle H2PtCl6 60oC hold 5min
user Perkins / Smith / Studer
email gary.perkins@ansto.gov.au

RunT 334 0 1 5

title Run10 - 62oC start increase 2/min 5 times H2PtCl6
sampledescription H2PtCl6 ramp to 70oC
samplename H2PtCl6 62oC start increase 2/min
sampletitle H2PtCl6 62oC start increase 2/min
user Perkins / Smith / Studer
email gary.perkins@ansto.gov.au

RadCollRamp 336 2 344 1

title Run11 - 70oC 5min hold H2PtCl6
sampledescription H2PtCl6 at 70oC
samplename H2PtCl6 70oC hold 5min
sampletitle H2PtCl6 70oC hold 5min
user Perkins / Smith / Studer
email gary.perkins@ansto.gov.au

RunT 344 0 1 5

title Run12 - 72oC start increase 2/min 5 times H2PtCl6
sampledescription H2PtCl6 ramp to 80oC
samplename H2PtCl6 72oC start increase 2/min
sampletitle H2PtCl6 72oC start increase 2/min
user Perkins / Smith / Studer
email gary.perkins@ansto.gov.au

RadCollRamp 346 2 354 1

title Run13 - 80oC 5min hold H2PtCl6
sampledescription H2PtCl6 at 80oC
samplename H2PtCl6 80oC hold 5min
sampletitle H2PtCl6 80oC hold 5min
user Perkins / Smith / Studer
email gary.perkins@ansto.gov.au

RunT 354 0 1 5

title Run14 - 82oC start increase 2/min 5 times H2PtCl6
sampledescription H2PtCl6 ramp to 90oC
samplename H2PtCl6 82oC start increase 2/min
sampletitle H2PtCl6 82oC start increase 2/min
user Perkins / Smith / Studer
email gary.perkins@ansto.gov.au

RadCollRamp 356 2 364 1

title Run15 - 90oC 5min hold H2PtCl6
sampledescription H2PtCl6 at 90oC
samplename H2PtCl6 90oC hold 5min
sampletitle H2PtCl6 90oC hold 5min
user Perkins / Smith / Studer
email gary.perkins@ansto.gov.au

RunT 364 0 1 5

title Run16 - 92oC start increase 2/min 5 times H2PtCl6
sampledescription H2PtCl6 ramp to 100oC
samplename H2PtCl6 92oC start increase 2/min
sampletitle H2PtCl6 92oC start increase 2/min
user Perkins / Smith / Studer
email gary.perkins@ansto.gov.au

RadCollRamp 366 2 374 1

title Run17 - 100oC 5min hold H2PtCl6
sampledescription H2PtCl6 at 100oC
samplename H2PtCl6 100oC hold 5min
sampletitle H2PtCl6 100oC hold 5min
user Perkins / Smith / Studer
email gary.perkins@ansto.gov.au

RunT 374 0 1 5
				