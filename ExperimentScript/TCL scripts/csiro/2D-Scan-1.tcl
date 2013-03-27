title X-Y scan of anode with 15x15 beam - refocussed 18:00 22/4/2009
sampletitle NbTiO2
samplename 
user csiro minerals / ajs
email ajs@ansto.gov.au



proc ScanY {start step numsteps oscno} {

	histmem mode unlimited
	newfile HISTOGRAM_XY
	for {set i 0} {$i < $numsteps} {incr i} {
		set j [expr $i*$step+$start]
		Ymove $j
		oscmd start $oscno
		hmm countblock
		save $i
	}
	oscmd stop
}

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
ScanY 80 5 10 1

Xmove 55
ScanY 80 5 10 1

Xmove 60
ScanY 80 5 10 1

Xmove 65
ScanY 80 5 10 1

Xmove 70
ScanY 80 5 10 1

