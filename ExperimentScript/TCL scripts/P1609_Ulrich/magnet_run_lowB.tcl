# This run goes to 1.0T in 0.1T steps, then winds down in 0.25 steps
foreach fld {0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0} {
	title [concat FeCr2S4 initial field $fld T, 4K]
	magnet send s $fld
	# wait for magnet to settle
	wait 30
	RadCollRun 1 10
}

foreach fld {0.75 0.5 0.25 0.0} {
	title [concat FeCr2S4 $fld T after ramping to 1.0T, 4K]
	magnet send s $fld
	# wait a bit longer for settling
	wait 60
	RadCollRun 1 10
}