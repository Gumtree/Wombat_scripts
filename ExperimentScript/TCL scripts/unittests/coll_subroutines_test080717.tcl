proc SimpleCollRun {numsteps range time} {
	histmem pause
	histmem stop 
	hmm configure fat_multiple_datasets disable
	histmem loadconf
	histmem mode unlimited
	oct speed 0.2
	drive oct [expr -$range]
	oct maxretry 0
	set spd [expr $range/$time]
	set timlim [expr $time+10]
	oct speed $spd
	oct accel $spd
	set prec 0.05
	newfile HISTOGRAM_XY
	histmem start
	
	for {set i 0} {$i < $numsteps} {incr i} {
		run oct [expr 1*$range]
		set j 0
		while {$j<$timlim} {
			wait 1.0
			incr j
			if {[expr abs([SplitReply [oct]]-$range)]< $prec} {
				break
			}
		}
		
		run oct [expr -1*$range]
		set j 0
		while {$j<$timlim} {
			wait 1.0
			incr j
			if {[expr abs([SplitReply [oct]]+$range)]< $prec} {
				break
			}
		}
	}
	histmem pause
	save
	histmem stop
	hmm configure fat_multiple_datasets enable
	histmem loadconf
	wait 5
	oct speed 0.2
}

SimpleCollRun 1 1 60
	