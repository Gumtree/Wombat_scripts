user Joel Bertinshaw

hset /sample/tc1/sensor/setpoint1 100
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
