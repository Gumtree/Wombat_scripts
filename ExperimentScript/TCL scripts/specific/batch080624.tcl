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

sampletitle Vn
sampledescription 
samplename
title Vn 2.41 radcoll
drive mom 53.4
SimpleRun 6676 1
title Vn 1.54 radcoll
drive mom 43.9
SimpleRun 6762 1
title Vn 1.22 radcoll
drive mom 68.4
SimpleRun 13221 1
title Vn 1.12 radcoll
drive mom 48.27
SimpleRun 16320 1

drive sphi -10
drive sphi 0

sampletitle bcg for Vn
sampledescription 
samplename
title bcg for Vn 2.41 radcoll
drive mom 53.4
SimpleRun 523 1
title bcg for Vn 1.54 radcoll
drive mom 43.9
SimpleRun 437 1
title bcg for Vn 1.22 radcoll
drive mom 68.4
SimpleRun 1178 1
title bcg for Vn 1.12 radcoll
drive mom 48.27
SimpleRun 5279 1

