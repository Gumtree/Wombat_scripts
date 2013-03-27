user Joel Bertinshaw
# This run goes from 3T to 4T in 0.1T steps.
# First set the magnet and temperature and wait for 10 minutes
SetRadColl 60 2

hset /sample/tc1/sensor/setpoint1 3
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
