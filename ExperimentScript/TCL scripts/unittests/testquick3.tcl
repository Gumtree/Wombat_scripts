proc SimpleCollRun {numsteps range time} {
	
	oct speed 0.2
	drive oct [expr -$range]
	oct maxretry 0
	set spd [expr $range*2/$time]
	set timlim [expr $time+10]
	oct speed $spd
	oct accel $spd
	set prec 0.05


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
	}
	
	oct speed 0.2
}

SimpleCollRun 1 1 60
	