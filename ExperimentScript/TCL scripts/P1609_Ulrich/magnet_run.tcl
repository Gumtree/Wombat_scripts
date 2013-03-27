user Joel Bertinshaw
# This run goes to 7.5T in 0.25T steps to 3T, 
# then 0.1T steps to 6T,
# then 0.25T steps to 7.5T

SetRadColl 60 2
set fld 1.0;
while {$fld <= 3.0} {
	title [concat FeCr2S4 $fld T during up ramp, 4K]
	set nominal_fld [expr $fld - 0.5]
	broadcast now going to $nominal_fld T
	magnet send s $nominal_fld
	# wait for magnet to settle
	wait 60
	broadcast Magnet at [eval magnet send ?]
	RadCollRun 1 10
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
	RadCollRun 1 10
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
	RadCollRun 1 10
	set fld [expr $fld + 0.25]
}

# Now we start winding down
set fld 7.25;
while {$fld >= 6} {
	title [concat FeCr2S4 $fld T during down ramp, 4K]
	set nominal_fld [expr $fld - 0.5]
	broadcast now going to $nominal_fld T on way down
	magnet send s $nominal_fld
	# wait for magnet to settle
	wait 180
	broadcast Magnet at [eval magnet send ?]
	RadCollRun 1 10
	set fld [expr $fld - 0.25]
}

set fld 5.9
while {$fld >= 3.0} {
	title [concat FeCr2S4 $fld T during down ramp, 4K]
	set nominal_fld [expr $fld - 0.5]
	broadcast now going to $nominal_fld T on way down
	magnet send s $nominal_fld
	# wait for magnet to settle
	wait 60
	broadcast Magnet at [eval magnet send ?]
	RadCollRun 1 10
	set fld [expr $fld - 0.1]
}

set fld 2.75
while {$fld >= 0.5} {
	title [concat FeCr2S4 $fld T during down ramp, 4K]
	set nominal_fld [expr $fld - 0.5]
	broadcast now going to $nominal_fld T on way down
	magnet send s $nominal_fld
	# wait for magnet to settle
	wait 60
	broadcast Magnet at [eval magnet send ?]
	RadCollRun 1 10
	set fld [expr $fld - 0.25]
}