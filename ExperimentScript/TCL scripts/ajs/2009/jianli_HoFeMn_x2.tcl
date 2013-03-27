

title Ho_Fe_Mn x is 0 in cryofurnace 10-450K 
sampledescription HoFeMnx x is zero 
samplename mtth 90 Ge 113 2.41A
user ajs / jianli wang
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
tc1 tolerance 30
tc2 tolerance 30
tc1 settle 3600
tc2 settle 3600

drive tc1 10 tc2 10

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

sampletitle ramp to 100K
RadCollRampCF1 10 1 91 1

sampletitle hold 10 mins at ~100K
RadCollTimed 1 10

sampletitle ramp to 200K
RadCollRampCF1 101 1 100 1

sampletitle hold 10 mins at ~200K
RadCollTimed 1 10

sampletitle ramp to 300K
RadCollRampCF1 201 1 100 1

sampletitle hold 10 mins at ~300K
RadCollTimed 1 10

sampletitle ramp to 400K
RadCollRampCF1 301 1 100 1

sampletitle hold 10 mins at ~400K
RadCollTimed 1 10

sampletitle ramp to 450K
RadCollRampCF1 401 1 50 1

sampletitle hold 10 mins at ~450K
RadCollTimed 1 10

#turn ramp off
tc1_asyncq send RAMP 1,0,1.2
wait 3
tc2_asyncq send RAMP 1,0,1.2
wait 3
tc1_asyncq send RELAY 2,2,1
drive tc1 320 tc2 320

