
sampletitle 
samplename 
drive oct 1


SetRadColl 60 2
title scan inert anode 5 to 15 step 1 from edge
		sy send SH`
		sy send PR`=-12500
		sy send BG`	
	RadCollOn 2
	histmem mode unlimited
	newfile HISTOGRAM_XY
	for {set i 0} {$i < 10} {incr i} {
		sy send SH`
		sy send PR`=2500
		sy send BG`	
		wait 5
			
		histmem start block
		save $i
	}	
		

