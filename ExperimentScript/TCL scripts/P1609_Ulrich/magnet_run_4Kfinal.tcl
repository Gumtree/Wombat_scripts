user Clemens Ulrich Joel Bertinshaw
# This run goes to 7.5T in 0.25T steps to 3T in 7min steps, 
# then 0.1T steps to 6T,
# then 0.25T steps to 7.5T

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

set fld 1.0;
while {$fld <= 3.0} {
	title [concat FeCr2S4 $fld T during up ramp, 4K]
	set nominal_fld [expr $fld - 0.5]
	broadcast now going to $nominal_fld T
	magnet send s $nominal_fld
	# wait for magnet to settle
	wait 60
	broadcast Magnet at [eval magnet send ?]
	RadCollRun 1 7
	set fld [expr $fld + 0.25]
}

set fld 3.1;
while {$fld <= 6.0} {
	title [concat FeCr2S4 $fld T during up ramp, 4K]
	set nominal_fld [expr $fld - 0.5]
        broadcast now going to $nominal_fld T
	magnet send s $nominal_fld
	# wait for magnet to settle
	wait 60
	broadcast Magnet at [eval magnet send ?]
	RadCollRun 1 7
	set fld [expr $fld + 0.1]
}

set fld 6.25
while {$fld <= 7.5} {
	title [concat FeCr2S4 $fld T during up ramp, 4K]
	set nominal_fld [expr $fld - 0.5]
	broadcast now going to $nominal_fld T
	magnet send s $nominal_fld
	# wait for magnet to settle
	wait 180
	broadcast Magnet at [eval magnet send ?]
	RadCollRun 1 7
	set fld [expr $fld + 0.25]
}

magnet send s 0
wait 600

#Ramping 4 to 15K for 4T, 5T and 5.5T

# set magnet to 4T (4-0.5)
magnet send s 3.5
wait 600
broadcast Magnet at [eval magnet send ?]
title FeCr2S4 at 4.0T ramp 4-15K in 1K steps
RadCollRamp 4 1 12 10

# reset temp to 4
hset /sample/tc1/sensor/setpoint1 3
hset /sample/tc1/sensor/setpoint2 3

# set magnet to 5T (5-0.5)
magnet send s 4.5
wait 600
broadcast Magnet at [eval magnet send ?]
title FeCr2S4 at 5.0T ramp 4-15K in 1K steps
RadCollRamp 4 1 12 10

# reset temp to 4
hset /sample/tc1/sensor/setpoint1 3
hset /sample/tc1/sensor/setpoint2 3

# set magnet to 5.5T (5.5-0.5)
magnet send s 5.0
wait 600
broadcast Magnet at [eval magnet send ?]
title FeCr2S4 at 5.5T ramp 4-15K in 1K steps
RadCollRamp 4 1 12 10

# reset temp to 4
hset /sample/tc1/sensor/setpoint1 3
hset /sample/tc1/sensor/setpoint2 3

# set magnet to 6T (6-0.5)
magnet send s 5.5
wait 600
broadcast Magnet at [eval magnet send ?]
title FeCr2S4 at 6.0T ramp 4-15K in 1K steps
RadCollRamp 4 1 12 10

# reset temp to 4
hset /sample/tc1/sensor/setpoint1 3
hset /sample/tc1/sensor/setpoint2 3

# set magnet to 6.5T (6.5-0.5)
magnet send s 6.0
wait 600
broadcast Magnet at [eval magnet send ?]
title FeCr2S4 at 6.5T ramp 4-15K in 1K steps
RadCollRamp 4 1 12 10

# reset temp to 4
hset /sample/tc1/sensor/setpoint1 3
hset /sample/tc1/sensor/setpoint2 3

# set magnet to 7.0T (7.0-0.5)
magnet send s 6.5
wait 600
broadcast Magnet at [eval magnet send ?]
title FeCr2S4 at 7.0T ramp 4-15K in 1K steps
RadCollRamp 4 1 12 10