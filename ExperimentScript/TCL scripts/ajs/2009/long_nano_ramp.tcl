

title nano tb coarse in cf3 long run
sampletitle nano tb
samplename mtth 90 Ge 113 2.41A
user studer 
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
tc1_asyncq send SETP 1,100
wait 3
tc1_asyncq send RAMP 1,1,1.2
wait 3
tc2_asyncq send RAMP 1,0,1.2
wait 3
tc2_asyncq send SETP 1,100
wait 3
tc2_asyncq send RAMP 1,1,1.2
wait 3



# cool down run

sampletitle at (sort of) base temp (100K)
RadCollTimed 1 5

sampletitle ramp to 210K
RadCollRampCF1 100 1 110 1

tc1_asyncq send RAMP 1,1,1.2
wait 3
tc2_asyncq send RAMP 1,1,1.2
wait 3

#so this time it's really 210 to 239
sampletitle ramp 210 to 240K
RadCollRampCF1 210 0.5 60 8

sampletitle ramp to 300K
RadCollRampCF1 240 1 60 1

sampletitle at 300K
RadCollTimed 1 5



#turn ramp off
tc1_asyncq send RAMP 1,0,1.0
wait 3
tc2_asyncq send RAMP 1,0,1.0
wait 3
drive tc1 300 tc2 300
tc1_asyncq send RELAY 2,2,1
