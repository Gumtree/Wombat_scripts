


proc SimpleCollRun {numsteps} {
	histmem stop 
	hmm configure fat_multiple_datasets disable
	histmem loadconf
	wait 5
	histmem mode unlimited
	oct speed 0.2
	drive oct 0
	oct maxretry 0
	oct precision 0.05
	oct accel 0.01
	oct speed 0.04
	newfile HISTOGRAM_XY
	for {set i 0} {$i <$numsteps} {incr i} {
		histmem start
		run oct 2
		wait 60
		run oct 0
		wait 60
		histmem pause
	}
	save 
	histmem stop
	hmm configure fat_multiple_datasets enable
	histmem loadconf
	wait 5
	oct accel 0.1
	oct speed 0.2
}

proc CollRun3D {numsteps numruns} {
	histmem mode unlimited
	oct speed 0.2
	drive oct 0
	oct maxretry 0
	oct precision 0.05
	oct accel 0.01
	oct speed 0.04
	newfile HISTOGRAM_XY
	for {set j 0} {$j <$numruns} {incr j} {
		histmem start
		for {set i 0} {$i <$numsteps} {incr i} {	
			run oct 2
			wait 60
			run oct 0
			wait 60
		}
		histmem pause
		wait 5
		save $j
		
	}
	oct accel 0.1
	oct speed 0.2
}

title ErNiAl4 fridge ramp 0-100K
for {set k 0} {$k <10} {incr k} {
	CollRun3D 1 60
}
