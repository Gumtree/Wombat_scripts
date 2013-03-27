
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
		if {$j== 0} {
			PulserOff
			set waszero 1
		} else {
			set pulservolt [expr {($j*1.0)/4000.0}]
			pulser send VOLT:OFFS $pulservolt
			if {$waszero==1} {
				PulserOn
				set waszero 0
			}
#			pulser send "APPL:DC DEF,DEF,$pulservolt"
		}
		texscan $tstart $tstep $tfin $oscno
		incr i
	}
	oscmd stop
}



proc HughScan {} {
	SetRadColl 60 2
	SetDC
	
	title 94BNT-6BT 0-14 bipolar 2.95A 25C
	sampledescription ramp 0 to +14kV step 1.75
	VoltTexRamp 1750 1750 14000 -45 10 135 1

	sampledescription  +13.25 to -14kV step -1.75
	VoltTexRamp 13250 -1750 -14000 -45 10 135 1

	sampledescription  -13.25 to 0kV step 1.75
	VoltTexRamp -13250 1750 0 -45 10 135 1
	
	#This is a comment
}

HughScan