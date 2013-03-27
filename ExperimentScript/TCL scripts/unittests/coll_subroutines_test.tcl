


proc SimpleCollRun {numsteps} {
	histmem stop 
	wait 5
	hmm configure fat_multiple_datasets disable
	histmem loadconf
	wait 5
	histmem mode unlimited
	oct speed 0.2
	drive oct -1
	oct speed 0.036
	newfile HISTOGRAM_XY
	histmem start
	for {set i 0} {$i <$numsteps} {incr i} {
		run oct 1
		wait 62
		run oct -1
		wait 62
	}
	histmem pause
	wait 10
	save 
	histmem stop
	wait 5
	hmm configure fat_multiple_datasets enable
	histmem loadconf
	wait 5
	oct speed 0.2
}
	
	
proc CollFlatScan {motor start step numsteps} {
	histmem stop 
	hmm configure fat_multiple_datasets disable
	histmem loadconf
	wait 5
	histmem mode unlimited
	oct speed 0.2
	drive oct -1
	oct speed 0.036
	newfile HISTOGRAM_XY
	for {set i 0} {$i <$numsteps} {incr i} {
		drive $motor [expr $i*$step+$start]
		histmem start
		run oct 1
		wait 62
		run oct -1
		wait 62
		histmem pause
		wait 5
	}
	save 
	histmem stop
	wait 5
	hmm configure fat_multiple_datasets enable
	histmem loadconf
	wait 5
	oct speed 0.2	
}	

title bcg for Al2O3 repeat for spangold @120deg 335 1.49A good shielding
SimpleCollRun 2