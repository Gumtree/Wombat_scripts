
# simple script to run a beam monitor scan in 2D
bmonscan clear
bmonscan setchannel 0
# set channel variable chooses which counter channel
# currently: wombat beam monitor = 0
#            shielded 3He        = 1
#            old hifar U235      = 2


# after the "bmonscan add" put the motor name,
# the start position and the step size
# after "bmonscan run " place the number of steps
# then the mode (timer or monitor) and the 
# time or monitor count for each step
title bmonscan for mom and mx
for {set i 0} {$i<2} {incr i} {
	drive my [expr ($i*2)+7]
	bmonscan clear
	bmonscan setchannel 1
	bmonscan add mx -10 2 
	bmonscan run 8 timer 5
}