

title Nd0.8Tb0.2Al2 in CF1 10-300K
sampledescription Nd0.8Tb0.2Al2
samplename mtth 90 Ge 113 2.41A
user ajs /grover / mona
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
tc2 controlsensor sensorA
tc1 range 5
tc2 range 5



tc1_asyncq send RAMP 1,0,1.2
wait 3
tc1_asyncq send SETP 1,5
wait 3
tc1_asyncq send RAMP 1,1,1.2
wait 3
tc2_asyncq send RAMP 1,0,1.2
wait 3
tc2_asyncq send SETP 1,5
wait 3
tc2_asyncq send RAMP 1,1,1.2
wait 3

#bug in sensor 1: occasionally trips out
tc1 UpperLimit 1000
tc2 UpperLimit 1000
tc1 tolerance 50
tc2 tolerance 50
tc1 settle 3600
tc2 settle 3600

drive tc1 5 tc2 5

base temp
sampletitle hold 10 mins at ~5K
RadCollTimed 1 10

sampletitle ramp to 350K
RadCollRampCF1 10 1 345 1

sampletitle hold 10 mins at ~350K
RadCollTimed 1 10

#turn ramp off
tc1_asyncq send RAMP 1,0,1.2
wait 3
tc2_asyncq send RAMP 1,0,1.2
wait 3
tc1_asyncq send RELAY 2,2,1
drive tc1 320 tc2 320

