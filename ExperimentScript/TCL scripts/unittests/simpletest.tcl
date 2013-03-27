


proc SimpleTest {numsteps range} {

	oct speed 0.2
	drive oct [expr -($range)]
	oct maxretry 0
	oct speed 0.036
	set precis [SplitReply [oct "precision"]]

	for {set i 0} {$i <$numsteps} {incr i} {
		run oct [expr $range]
		set j 0
		while {j = 0} {
			wait 0.2
			if {[expr abs([SplitReply [oct]] - $range)]< $precis} {set j 1}
		}
		wait 0.5
		run oct $range
		set j 0
		while {j = 0} {
			wait 0.2
			if {[expr abs([SplitReply [oct]] - $range)]< $precis} {set j 1}
		}
	}
	
	wait 5
	oct speed 0.2
}
	

title testradcoll
SimpleCTest 1	0.5
	
	