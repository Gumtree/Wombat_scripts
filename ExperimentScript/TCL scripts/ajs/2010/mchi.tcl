

title scan mchi 0 to -25000 in -2500
sampledescription al2o3
samplename al2o3
sampletitle al2o3
user ajs
email ajs

SetRadColl 60 2

proc mchirun {step numsteps oscno} {
	histmem mode time
	histmem preset 10	
	newfile HISTOGRAM_XY
	for {set i 0} {$i < $numsteps} {incr i} {
		mchi send PR`=$step
		mchi send BG`
		wait 5
			
		
		hmm countblock
		save $i
	}
	
}
	
mchirun -2500 10 1 		
	
	