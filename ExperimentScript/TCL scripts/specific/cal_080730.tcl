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
		wait 5
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


samplename bcg for Vn (REAL this time)
sampletitle nothing (Vn support stick)
drive mom 44.0
title Vn bcg at 1.54A DEFINITELY BCG
ScanFlat stth 15 0.5 30 240






