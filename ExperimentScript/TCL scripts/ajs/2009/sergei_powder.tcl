

title Ag10Cu10Se Danilikin
sampledescription 
sampletitle Ag10Cu10Se
samplename mtth 90 Ge 115 1.54A
user Danilikin / ajs + collab
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
tc1 lowerlimit 0
tc2 lowerlimit 0
tc1 tolerance 50
tc2 tolerance 50
tc1 settle 0
tc2 settle 0
tc1 upperlimit 630
tc2 upperlimit 630

tc1_asyncq send RAMP 1,0,1.2
wait 3
tc1_asyncq send SETP 1,300
wait 3
tc1_asyncq send RAMP 1,1,1.2
wait 3
tc2_asyncq send RAMP 1,0,1.2
wait 3
tc2_asyncq send SETP 1,300
wait 3
tc2_asyncq send RAMP 1,1,1.2
wait 3

#base temp
sampletitle hold 10 mins at ~300K
RadCollTimed 1 10

sampletitle ramp to 495K
RadCollRampCF1 300 1 196 1

sampletitle hold at 495K
RadCollTimed 1 10

sampletitle ramp to 523K
RadCollRampCF1 496 1 27 1

sampletitle hold at 523K
RadCollTimed 1 10

sampletitle ramp to 623K
RadCollRampCF1 524 1 100 1

sampletitle hold at 623K
RadCollTimed 1 10


#turn ramp off
tc1_asyncq send RAMP 1,0,1.2
wait 3
tc2_asyncq send RAMP 1,0,1.2
wait 3
tc1_asyncq send RELAY 2,2,1
wait 3
tc1_asyncq send SETP 1,300
wait 3
tc2_asyncq send SETP 1,300
wait 3

sampletitle run while cooling back to 300K
RadCollTimed 1 240


