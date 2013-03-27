

title BaBi2Nb2O9 in CF3 ~10-600K
sampledescription BaBi2Nb2O9
sampletitle BaBi2Nb2O9
samplename mtth 90 Ge 115 1.54A
user Liu / Noren / ajs
email ajs@ansto.gov.au

proc RadCollRampCF1 {start step numsteps oscno} {
	tc1_asyncq send SETP 1,$start
	tc2_asyncq send SETP 1,$start
	histmem mode unlimited
	newfile HISTOGRAM_XY
	for {set i 0} {$i < $numsteps} {incr i} {
		set j [expr $i*$step+$start]
		tc1_asyncq send SETP 1,$j
		tc2_asyncq send SETP 1,$j
		oscmd start $oscno
		hmm countblock
		save $i
	}
	oscmd stop
}

SetRadColl 60 2
tc1 controlsensor sensorC
tc2 controlsensor sensorD
tc1 range 5
tc2 range 5


tc1_asyncq send RAMP 1,0,2.4
wait 3
tc1_asyncq send SETP 1,50
wait 3
tc1_asyncq send RAMP 1,1,2.4
wait 3
tc2_asyncq send RAMP 1,0,2.4
wait 3
tc2_asyncq send SETP 1,50
wait 3
tc2_asyncq send RAMP 1,1,2.4
wait 3



sampletitle ramp to 600K
RadCollRampCF1 50 2 275 1




#turn ramp off
tc1_asyncq send RAMP 1,0,2.4
wait 3
tc2_asyncq send RAMP 1,0,2.4
wait 3
tc1_asyncq send RELAY 2,2,1
wait 3
tc1_asyncq send SETP 1,300
wait 3
tc2_asyncq send SETP 1,300
wait 3




