title Y scan of anode with 15x15 beam - refocussed 18:00 22/4/2009
sampletitle EB New Blank rpt
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

Xmove 65
ScanY 70 5 20 1
