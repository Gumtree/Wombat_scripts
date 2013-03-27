proc SetBinning {x y} {
	
	histmem stop
	wait 5
	oat_table -set X {991.5 [expr 991.5-$x]} Y {-0.5 [expr -0.5+$y]} T {0 20000}
	oat_table -set NXC [expr 992/$x] NYC [expr 512/$y] NTC 1
	fat_table -set MULTI_HOST_HISTO_STITCH_OVERLAP [expr 32/$x]
	fat_table -set VIEW_MAG_X [expr $x/4]
	fat_table -set VIEW_MAG_Y $y
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

sampletitle 
sampledescription Standard Vanadium bar
samplename Vanadium

drive mom 53.4

title Vn compare binning 1x1 2.41A

SetBinning 1 1

histmem mode time
histmem preset 1800
newfile HISTOGRAM_XY
histmem start block
save 
histmem stop

title Vn compare binning 4x4 2.41A

SetBinning 4 4

histmem mode time
histmem preset 1800
newfile HISTOGRAM_XY
histmem start block
save 
histmem stop


drive mom 53.4

SetBinning 1 1
title Vn 3872x512 2.41A
ScanFlat stth 20 0.1 10 1260

SetBinning 4 4
title Vn 968x128 2.41A
ScanFlat stth 20 0.1 10 720

drive mom 43.9
title Vn 968x128 1.54A
ScanFlat stth 20 0.1 10 720

sampledescription no sample 
samplename background

drive sphi -10
drive sphi 0

drive mom 53.4

SetBinning 1 1
title bcg for Vn 3872x512 2.41A
ScanFlat stth 20 0.1 10 1260

SetBinning 4 4
title bcg for Vn 968x128 2.41A
ScanFlat stth 20 0.1 10 720

drive mom 43.9
title bcg forVn 968x128 1.54A
ScanFlat stth 20 0.1 10 720

