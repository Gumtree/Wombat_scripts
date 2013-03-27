

title Nd0.775Tb0.225Al2 in CF4 6-90K 0-3T
sampledescription Nd0.825Tb0.175Al2 in CF4 6-90K 0-3T
samplename mtth 55 Ge 113 1.57A
sampletitle Nd0.825Tb0.175Al2 in CF4 6-90K 0-3T
user "prasaanna / grover / mona / ajs"
email ajs@ansto.gov.au

proc RadCollRamp {start step numsteps oscno} {
	
	histmem mode unlimited
	newfile HISTOGRAM_XY
	for {set i 0} {$i < $numsteps} {incr i} {
		set j [expr $i*$step+$start]
		run tc1_driveable $j tc1_driveable2 $j
		oscmd start $oscno
		hmm countblock
		save $i
	}
	oscmd stop
}
SetRadColl 60 2

proc RunT {temp delay numsteps} {
	run tc1_driveable $temp tc1_driveable2 $temp
	wait $delay
	newfile HISTOGRAM_XY
	for {set i 0} {$i < $numsteps} {incr i} {	
		oscmd start 1
		hmm countblock
		save $i
	}
}

proc RunCycle {mfield} {
	

	title Nd0.775Tb0.225Al2 in CF4 field 5T T=90K
	RunT 90 10 9
	
	title Nd0.775Tb0.225Al2 in CF4 field 5T T=70K
	RunT 70 360 9
	
	title Nd0.775Tb0.225Al2 in CF4 field 5T T=50K
	RunT 50 360 9
	title Nd0.775Tb0.225Al2 in CF4 field 5T T=30K
	RunT 30 120 9
	
	title Nd0.775Tb0.225Al2 in CF4 field 5T T=20K
	RunT 20 120 9
	
	title Nd0.775Tb0.225Al2 in CF4 field 5T T=6K
	RunT 6 120 9
	
}

RunCycle 0

