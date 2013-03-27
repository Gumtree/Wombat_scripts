SetRadColl 60 2

proc RunT {temp delay numsteps oscno} {
	hset /sample/tc1/sensor/setpoint1 $temp
	hset /sample/tc1/sensor/setpoint2 $temp
	wait $delay
#	drive tc1_driveable $temp tc1_driveable2 $temp
	
	newfile HISTOGRAM_XY
	for {set i 0} {$i < $numsteps} {incr i} {	
		oscmd start $oscno
		hmm countblock
		save $i
	}
}


proc RadCollRamp {start step numsteps oscno} {
	
	histmem mode unlimited
	newfile HISTOGRAM_XY
	for {set i 0} {$i < $numsteps} {incr i} {
		set j [expr $i*$step+$start]
#		run tc1_driveable $j tc1_driveable2 $j
		hset /sample/tc1/sensor/setpoint1 $j
		hset /sample/tc1/sensor/setpoint2 $j
		oscmd start $oscno
		hmm countblock
		save $i
	}
	oscmd stop
}

# set magnet to 3T (3-0.5)
magnet send s 2.5
wait 600
broadcast Magnet at [eval magnet send ?]
title FeCr2S4 at 3T ramp 4-15K in 1K steps
RadCollRamp 4 1 12 10

# reset temp to 4
hset /sample/tc1/sensor/setpoint2 3
hset /sample/tc1/sensor/setpoint2 3

# set magnet to 4.5T (4.5-0.5)
magnet send s 4.0
wait 600
broadcast Magnet at [eval magnet send ?]
title FeCr2S4 at 4.5T ramp 4-15K in 1K steps
RadCollRamp 4 1 12 10

# reset temp to 4
hset /sample/tc1/sensor/setpoint2 3
hset /sample/tc1/sensor/setpoint2 3

# set magnet to 7.5T (7.5-0.5)
magnet send s 7.0
wait 600
broadcast Magnet at [eval magnet send ?]
title FeCr2S4 at 7.5T ramp 4-15K in 1K steps
RadCollRamp 4 1 12 10

