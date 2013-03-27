title 
sampletitle Al2O3 45mm x 6mm dia
samplename 
drive oct 1

SetRadColl 60 2
title scan Ge 115 from 50 to 110, testing mom 115
	for {set i 0} {$i < 13} {incr i} {
		set mval [expr $i*5+50]
		drive mtth $mval
		set mval2 [expr ($mval/2)-0.9-0.5]
		drive mom $mval2
		RadCollScan mom $mval2 0.05 21 1
	}	
		
title scan Ge 113 from 50 to 110, testing mom 113
	for {set i 0} {$i < 13} {incr i} {
		set mval [expr $i*5+50]
		drive mtth $mval
		set mval2 [expr ($mval/2)-0.9-0.5+9.45]
		drive mom $mval2
		RadCollScan mom $mval2 0.05 21 1
	}	

title scan Ge 115 from 50 to 110, testing mf2 115
	for {set i 0} {$i < 13} {incr i} {
		set mval [expr $i*5+50]
		drive mtth $mval
		set mval2 [expr ($mval/2)-0.9]
		drive mom $mval2
		RadCollScan mf2 0 0.05 17 1
	}
	
title scan Ge 113 from 50 to 110, testing mf2 113
	for {set i 0} {$i < 13} {incr i} {
		set mval [expr $i*5+50]
		drive mtth $mval
		set mval2 [expr ($mval/2)-0.9+9.45]
		drive mom $mval2
		RadCollScan mf2 0 0.05 17 1
	}		