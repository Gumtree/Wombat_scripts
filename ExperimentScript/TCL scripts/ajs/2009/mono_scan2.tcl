title 
sampletitle Al2O3 45mm x 6mm dia
samplename 
drive oct 1

SetRadColl 60 2
title very fine mf2 scan Ge 115
	for {set i 0} {$i < 11} {incr i} {
		set mval [expr $i*0.1+89.5]
		drive mchi $mval

		RadCollScan mf2 0.2 0.01 41 1
	}	
		
drive mom 53.4
		
title very fine mf2 scan Ge 113
		for {set i 0} {$i < 1} {incr i} {
		set mval [expr $i*0.1+89.5]
		drive mchi $mval

		RadCollScan mf2 0.2 0.01 41 1
	}	

