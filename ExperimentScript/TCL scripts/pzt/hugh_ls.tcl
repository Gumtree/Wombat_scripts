
proc VoltTexRamp {vstart vstep vfin tstart tstep tfin oscno} {
	histmem mode unlimited
	set waszero 0
	set loopvar 1
	set i 0 
	while {$loopvar} {
		set j [expr {$i*$vstep+$vstart}]
		if {$j> $vfin && $vstep > 0} {break}
		if {$j< $vfin && $vstep < 0} {break}
		samplename Voltage $j
		lsv $j
		SimpleRun 180 1
		texscan $tstart $tstep $tfin $oscno
		incr i
	}
	oscmd stop
}



proc HughScan {} {
	SetRadColl 60 2
	
	title 94BNT-6BT 0-14 bipolar 2.95A 25C
	sampledescription ramp 0 to +14kV step 1.75
	VoltTexRamp 0 1750 14000 -45 15 135 1

	sampledescription  +12.25 to -14kV step -1.75
	VoltTexRamp 12250 -1750 -14000 -45 15 135 1

	sampledescription  -12.25 to 0kV step 1.75
	VoltTexRamp -12250 1750 0 -45 15 135 1
	
	#This is a comment
}

HughScan
