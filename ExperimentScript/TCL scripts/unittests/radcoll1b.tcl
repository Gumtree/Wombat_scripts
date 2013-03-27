# code #1 to move radial collimator - can I talk to the histo and
# get a position 
# v1a start histo, loop and wait
# v1b start histo, loop, put oct send in loop


proc RCTest1
	oct speed 0.2
	drive oct -1
	oct speed 0.02
	
	histmem mode unlimited
	histmem pause
	histmem start
	
	for {set i 0} {$i < 10} {incr i} {
			wait 2.0
			oct send TPG
	}
	histmem pause
}	
	