

title BiNaTiO3 cooldown 125C to RT redododo
sampledescription BiNaTiO3
samplename mtth 90 Ge 113 2.41A
user Bond / Hugh Simons
email ajs@ansto.gov.au

proc RadCollRampCF1 {start step numsteps oscno} {
	
	histmem mode unlimited
	newfile HISTOGRAM_XY
	for {set i 0} {$i < $numsteps} {incr i} {
		set j [expr $i*$step+$start]
	    tc2_asyncq send SETP 2,$j
		oscmd start $oscno
		hmm countblock
		save $i
	}
	oscmd stop
}



proc TempReset {strt rmp} {
	tc2_asyncq send RAMP 1,0,$rmp
	wait 3
	tc2_asyncq send SETP 1,$strt
	wait 3
	tc2_asyncq send RAMP 1,1,$rmp
	wait 3

}

#bug in sensor 1: occasionally trips out

SetRadColl 60 2
tc2 controlsensor sensorA
tc2 range 5

sampletitle 125 deg 1.7K/min
TempReset 398 -1.9
RadCollRampCF1 398 -1.7 30 1
RadCollRun 1 20
RadCollRampCF1 348 -1.7 30 1
