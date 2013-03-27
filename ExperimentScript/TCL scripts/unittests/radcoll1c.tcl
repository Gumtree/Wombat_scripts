# code #1 to move radial collimator - can I talk to the histo and
# get a position 
# v1a start histo, loop and wait
# v1b start histo, loop, put oct send in loop
# v1c OK, so oct send works, try matching using _BG


proc RCTest1
	oct speed 0.2
	drive oct -1
	oct speed 0.02
	octhome = [SplitReply [oct absEncHome]]
	octsteps = [SplitReply [oct stepsPerX]]
	
	histmem mode unlimited
	histmem pause
	histmem start
	oct send PR` [format "%u" [$octhome]]
	oct send BG`
	for {set i 0} {$i < 100} {incr i} {
			if {[string match [oct send MG _BG`] {*1*}] = 1} {
				break
			}
			wait 2.0
	}
	histmem pause
}	
	