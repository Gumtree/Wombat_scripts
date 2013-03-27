# proc to set up rad coll

proc ::histogram_memory::pre_count {} {
#        global oct_cycles
#       oscmd start 1
}
proc CollAxisScan {motor start step numsteps} {

	histmem mode time
	histmem preset 5
	newfile HISTOGRAM_XY
	for {set i 0} {$i <$numsteps} {incr i} {
		drive $motor [expr $i*$step+$start]
		histmem start block
		save $i
	}
}	



title Cu1.8Se scan eom to find 004

#drive sphi -2.5
#drive schi 88.5

#drive echi -7.5
CollAxisScan eom  -35 1 30
#drive echi 0
#CollAxisScan ephi  30 1 30
#drive echi 7.5
#CollAxisScan ephi  30 1 30


# uncomment this to kill rad coll
#proc ::histogram_memory::pre_count {} {}
