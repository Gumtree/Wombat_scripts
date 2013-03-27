


proc SimpleCollRun {numsteps} {
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
		histmem start
		run oct 1
		wait 60
		run oct -1
		wait 60
		histmem pause
	}
	save 
	histmem stop
	hmm configure fat_multiple_datasets enable
	histmem loadconf
	wait 5
	oct speed 0.2
}
	
sampletitle Vn
sampledescription 
samplename
title Vn 2.41 radcoll moving
drive mom 53.4
SimpleCollRun 90
title Vn 1.54 radcoll moving
drive mom 43.9
SimpleCollRun 90


drive sphi -10
drive sphi 0

sampletitle bcg for Vn
sampledescription 
samplename
title bcg for Vn 2.41 radcoll moving
drive mom 53.4
SimpleCollRun 90
title bcg for Vn 1.54 radcoll moving
drive mom 43.9
SimpleCollRun 90


