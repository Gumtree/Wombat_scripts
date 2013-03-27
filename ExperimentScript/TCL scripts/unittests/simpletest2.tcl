


proc SimpleTest {numsteps range} {
	oct speed 0.2
	drive oct [expr -($range)]
	oct maxretry 0
	oct speed 0.036
	set precis [SplitReply [oct "precision"]]

}	
	
SimpleTest 1 1	