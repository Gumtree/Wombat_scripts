title scanning anode for som=30-45 
sampletitle EB 4Hr
samplename 
user csiro minerals / ajs
email ajs@ansto.gov.au

proc ScanX {start step numsteps oscno} {

	histmem mode unlimited
	newfile HISTOGRAM_XY
	for {set i 0} {$i < $numsteps} {incr i} {
		set j [expr $i*$step+$start]
		Xmove $j
		oscmd start $oscno
		hmm countblock
		save $i
	}
	oscmd stop
}

SetRadColl 60 2

Xmove 50
RadCollScan som 20 5 6 1 
