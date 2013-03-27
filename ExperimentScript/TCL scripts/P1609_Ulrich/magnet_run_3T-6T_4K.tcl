user Joel Bertinshaw
# This run goes from 3T to 6T in 0.1T steps.
# First set the magnet and wait
SetRadColl 60 2

magnet send s 2.5
wait 300

set fld 3.0;
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
