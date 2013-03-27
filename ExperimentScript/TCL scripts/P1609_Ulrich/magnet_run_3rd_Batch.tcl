user Clemens Ulrich Joel Bertinshaw
# This run goes to 7.5T in 0.25T steps to 3T, 
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

set fld 4.2;
while {$fld <= 6.0} {
	title [concat FeCr2S4 $fld T during up ramp, 15K]
	set nominal_fld [expr $fld - 0.5]
	broadcast now going to $nominal_fld T
	magnet send s $nominal_fld
	# wait for magnet to settle
	wait 60
	broadcast Magnet at [eval magnet send ?]
	RadCollRun 1 10
	set fld [expr $fld + 0.1]
}

set fld 6.25
while {$fld <= 7.5} {
	title [concat FeCr2S4 $fld T during up ramp, 15K]
	set nominal_fld [expr $fld - 0.5]
	broadcast now going to $nominal_fld T
	magnet send s $nominal_fld
	# wait for magnet to settle
	wait 180
	broadcast Magnet at [eval magnet send ?]
	RadCollRun 1 10
	set fld [expr $fld + 0.25]
}

#Setting up magnetic field for next run
magnet send s 0.0
wait 600


# This run goes from 3T to 4T in 0.1T steps.
# First set the magnet and temperature and wait for 10 minutes
hset /sample/tc1/sensor/setpoint2 3
hset /sample/tc1/sensor/setpoint2 3
wait 600

magnet send s 2.5
wait 600

set fld 3.0;
while {$fld <= 4.0} {
	title [concat FeCr2S4 $fld T during up ramp, 4K]
	set nominal_fld [expr $fld - 0.5]
	broadcast now going to $nominal_fld T
	magnet send s $nominal_fld
	# wait for magnet to settle
	wait 60
	broadcast Magnet at [eval magnet send ?]
	RadCollRun 1 10
	set fld [expr $fld + 0.1]
}

#Setting up magnetic field for next run
magnet send s 0.0
wait 300


#Ramping 4 to 15K for 3T, 4.5T and 7.5T

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

# 100K magnet run from 1 to 7.5T in 0.25T steps

hset /sample/tc1/sensor/setpoint2 100
hset /sample/tc1/sensor/setpoint2 100
magnet send s 0
wait 900

SetRadColl 60 2
set fld 1.0;
while {$fld <= 7.5} {
	title [concat FeCr2S4 $fld T during up ramp, 100K]
	set nominal_fld [expr $fld - 0.5]
	broadcast now going to $nominal_fld T
	magnet send s $nominal_fld
	# wait for magnet to settle
	wait 60
	broadcast Magnet at [eval magnet send ?]
	RadCollRun 1 10
	set fld [expr $fld + 0.25]
}


