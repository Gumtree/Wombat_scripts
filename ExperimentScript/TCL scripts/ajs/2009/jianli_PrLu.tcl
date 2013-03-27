

title Pr0.6Lu0.4Mn2Ge2 in cryofurnace 10-450K 
sampletitle 
samplename mtth 90 Ge 113 2.41A
user ajs / jianli wang
email ajs@ansto.gov.au

proc RadCollRampCF1 {start step numsteps oscno} {

	RadCollOn $oscno
	histmem mode unlimited
	newfile HISTOGRAM_XY
	for {set i 0} {$i < $numsteps} {incr i} {
		set j [expr $i*$step+$start]
		tc1_asyncq send SETP 1,$j
		tc2_asyncq send SETP 1,$j
		histmem start block
		save $i
	}
	RadCollOff
}

SetRadColl 60 2
tc1 controlsensor sensorA
tc2 controlsensor sensorA
tc1 range 5
tc2 range 5

#tc1 tolerance 50
#tc2 tolerance 50
#tc1 settle 0
#tc2 settle 0

#drive tc1 5 tc2 5

#wait 3600
#wait 3600

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
wait 3

#base temp
sampletitle hold 10 mins at ~10K
RadCollTimed 1 10

sampletitle ramp to 100K
RadCollRampCF1 10 1 91 1

sampletitle hold 10 mins at ~100K
RadCollTimed 1 10

sampletitle ramp to 250K
RadCollRampCF1 101 1 150 1

sampletitle hold 10 mins at ~250K
RadCollTimed 1 10

sampletitle ramp to 350K
RadCollRampCF1 251 1 100 1

sampletitle hold 10 mins at ~350K
RadCollTimed 1 10

sampletitle ramp to 450K
RadCollRampCF1 351 1 100 1

sampletitle hold 10 mins at ~450K
RadCollTimed 1 10



#turn ramp off
tc1_asyncq send RAMP 1,0,1.0
wait 3
tc2_asyncq send RAMP 1,0,1.0
wait 3
drive tc1 300 tc2 300
tc1_asyncq send RELAY 2,2,1
