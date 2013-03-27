
proc SimpleTsom {tstart tstep tfin time} {
	newfile HISTOGRAM_XY
	histmem mode time
	histmem preset $time
	set i 0 
	while {1} {
		set j [expr {$i*$tstep+$tstart}]
		if {$j> $tfin && $tstep > 0} {break}
		if {$j< $tfin && $tstep < 0} {break}
		tsom $j
		hmm countblock
		save $i
		incr i
	}
}



title BNT-BT single xtal at 1.44A quick test
samplename BNT-BT xtal (001) in plane somewhere, others unknown
sampletitle BNT-BT xtal
sampledescription BNT-BT xtal
name John Daniels

SimpleTsom -45 0.25 45 2
