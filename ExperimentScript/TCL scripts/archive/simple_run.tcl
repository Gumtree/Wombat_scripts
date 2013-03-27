proc SetBinning {x y} {
	
	histmem stop
	wait 5
	oat_table -set X {991.5 [expr 991.5-$x]} Y {-0.5 [expr -0.5+$y]} T {0 20000}
	oat_table -set NXC [expr 992/$x] NYC [expr 512/$y] NTC 1
	fat_table -set MULTI_HOST_HISTO_STITCH_OVERLAP [expr 32/$x]
	histmem loadconf
	wait 5
}	

proc ScanFlat {motor start step numsteps steptime} {
	hmm configure fat_multiple_datasets disable
	histmem loadconf
	wait 5
	drive $motor $start
	histmem mode time
	histmem preset $steptime
	newfile HISTOGRAM_XY
	for {set i 0} {$i <$numsteps} {incr i} {
		drive $motor [expr $i*$step+$start]
		histmem start block
	}
	save 
	histmem stop
	hmm configure fat_multiple_datasets enable
	histmem loadconf
	wait 5
}

proc Scan3D {motor start step numsteps steptime} {
	hmscan clear
	hmm configure fat_multiple_datasets enable
	histmem loadconf
	wait 5
	histmem mode time
	histmem preset $steptime
	newfile HISTOGRAM_XY	
	for {set i 0} {$i <$numsteps} {incr i} {
		drive $motor [expr $i*$step+$start]
		histmem start block
	save $i
	}
}

proc SimpleRun {steptime numsteps} {
	hmm configure fat_multiple_datasets enable
	histmem loadconf
	wait 5
	histmem mode time
	histmem preset $steptime
	for {set i 0} {$i < $numsteps} {incr i} {
		newfile HISTOGRAM_XY
		histmem start block
		save
	}
}

proc ColRun {duumvar} {
	set oct speed 0.2
	drive oct -1
	set oct speed 0.035
	histmem mode time
	histmem preset 120
	newfile HISTOGRAM_XY
	histmem start
	drive oct 1
	drive oct -1
	save
}

	

sampletitle nothing
sampledescription 
samplename
title test collimator run
ColRun 1

