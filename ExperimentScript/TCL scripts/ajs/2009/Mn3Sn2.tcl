

title Mn2.4Ni0.6Sn2 in CF1 10-300K
sampledescription Mn2.4Ni0.6Sn2
samplename mtth 90 Ge 113 2.41A
user ajs / rong zheng / jianli wang
email ajs@ansto.gov.au

proc RadCollRampCF1 {start step numsteps oscno} {
	
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
tc1 controlsensor sensorA
tc2 controlsensor sensorC
tc1 range 5
tc2 range 5



tc1_asyncq send RAMP 1,0,1.2
wait 3
tc1_asyncq send SETP 1,10
wait 3
tc1_asyncq send RAMP 1,1,1.2
wait 3
tc2_asyncq send RAMP 1,0,1.2
wait 3
tc2_asyncq send SETP 1,10
wait 3
tc2_asyncq send RAMP 1,1,1.2
wait 3

#bug in sensor 1: occasionally trips out
tc1 UpperLimit 1000
tc2 UpperLimit 1000
tc1 tolerance 1000
tc2 tolerance 1000
tc1 settle 0
tc2 settle 0



base temp
sampletitle hold 10 mins at ~10K
RadCollTimed 1 10

sampletitle ramp to 25K
RadCollRampCF1 10 01 15 1

sampletitle hold 10 mins at ~25K
RadCollTimed 1 10

sampletitle ramp to 50K
RadCollRampCF1 25 1 25 1

sampletitle hold 10 mins at ~50K
RadCollTimed 1 10

sampletitle ramp to 100K
RadCollRampCF1 50 1 50 1

sampletitle hold 10 mins at ~100K
RadCollTimed 1 10

sampletitle ramp to 210K
RadCollRampCF1 100 1 110 1

sampletitle hold 10 mins at ~210K
RadCollTimed 1 10

sampletitle ramp to 250K
RadCollRampCF1 210 1 40 1

sampletitle hold 10 mins at ~250K
RadCollTimed 1 10

sampletitle ramp to 250K
RadCollRampCF1 210 1 40 1

sampletitle hold 10 mins at ~250K
RadCollTimed 1 10

sampletitle ramp to 350K
RadCollRampCF1 250 1 100 1

sampletitle hold 10 mins at ~350K
RadCollTimed 1 10

#turn ramp off
tc1_asyncq send RAMP 1,0,1.2
wait 3
tc2_asyncq send RAMP 1,0,1.2
wait 3
tc1_asyncq send RELAY 2,2,1
drive tc1 320 tc2 320

