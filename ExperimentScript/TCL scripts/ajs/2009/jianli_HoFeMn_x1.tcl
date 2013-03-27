

title Ho_Fe_Mn x=1 in cryofurnace 10-450K 
sampletitle HoFeMnx x is 1
samplename mtth 90 Ge 113 2.41A
user vkp / jianli wang
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

tc1 tolerance 50
tc2 tolerance 50
tc1 settle 0
tc2 settle 0

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
tc1_asyncq send RAMP 1,0,1.0
wait 3
tc2_asyncq send RAMP 1,0,1.0
wait 3
drive tc1 300 tc2 300
tc1_asyncq send RELAY 2,2,1
