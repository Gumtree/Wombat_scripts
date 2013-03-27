

title LaCaMnO3 in CF1
sampletitle LaCaMnO3
samplename mtth 90 Ge 113 2.41A
user ajs / cheng wgong
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
tc1 settle 3600
tc2 settle 3600

wait 1800
tc1_asyncq send RELAY 2,2,0

drive tc1 20 tc2 20

tc1_asyncq send RAMP 1,0,1.2
wait 3
tc1_asyncq send SETP 1,20
wait 3
tc1_asyncq send RAMP 1,1,1.2
wait 3
tc2_asyncq send RAMP 1,0,1.2
wait 3
tc2_asyncq send SETP 1,20
wait 3
tc2_asyncq send RAMP 1,1,1.2
wait 3


#base temp
sampletitle hold 10 mins at ~20K
RadCollTimed 1 10

sampletitle ramp to 150K
RadCollRampCF1 20 1 130 1



sampletitle ramp to 300K
RadCollRampCF1 150 1 150 1


#turn ramp off
tc1_asyncq send RAMP 1,0,1.0
wait 3
tc2_asyncq send RAMP 1,0,1.0
wait 3
drive tc1 300 tc2 300
tc1_asyncq send RELAY 2,2,1
