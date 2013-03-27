

title MnO2 in CF1 8-300K
sampledescription MnO2
samplename mtth 90 Ge 113 2.41A
user ajs / rong zheng
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
tc1_asyncq send SETP 1,8
wait 3
tc1_asyncq send RAMP 1,1,1.2
wait 3
tc2_asyncq send RAMP 1,0,1.2
wait 3
tc2_asyncq send SETP 1,8
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
sampletitle hold 10 mins at ~8K
RadCollTimed 1 10

sampletitle ramp to 20K
RadCollRampCF1 8 0.5 24 1

sampletitle hold 10 mins at ~20K
RadCollTimed 1 10

sampletitle ramp to 60K
RadCollRampCF1 20 0.5 80 1

sampletitle hold 10 mins at ~60K
RadCollTimed 1 10

sampletitle ramp to 180K
RadCollRampCF1 60 0.5 240 1

sampletitle hold 10 mins at ~180K
RadCollTimed 1 10

sampletitle ramp to 300K
RadCollRampCF1 180 0.5 240 1

sampletitle hold 10 mins at ~300K
RadCollTimed 1 10


#turn ramp off
tc1_asyncq send RAMP 1,0,1.2
wait 3
tc2_asyncq send RAMP 1,0,1.2
wait 3
tc1_asyncq send RELAY 2,2,1
drive tc1 320 tc2 320

