title X-Y scan of anode with 5x40 beam - refocussed 18:00 22/4/2009
sampletitle Eb 7hr
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

Ymove 95
ScanX 50 2 15 1


Ymove 105
ScanX 50 2 15 1

