

title H2PtCl6 in standard heating cycle
sampledescription H2PtCl6
sampletitle H2PtCl6
samplename mtth 90 Ge 113 2.41A
user Gary Perkins / SS / ajs
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

tc1_asyncq send RAMP 1,0,5
wait 3
tc1_asyncq send SETP 1,283
wait 3
tc1_asyncq send RAMP 1,1,5
wait 3
tc2_asyncq send RAMP 1,0,5
wait 3
tc2_asyncq send SETP 1,283
wait 3
tc2_asyncq send RAMP 1,1,5
wait 3

#base temp


sampletitle ramp to 463K
RadCollRampCF1 283 5 36 1

sampletitle hold at 463K for 18 min
RadCollTimed 1 18

sampletitle ramp to 563K
RadCollRampCF1 463 5 20 1

sampletitle hold at 563K
RadCollTimed 1 18

sampletitle ramp to 573K
RadCollRampCF1 563 5 2 1

sampletitle hold at 573K
RadCollTimed 1 18

#turn heater off

tc1_asyncq send RAMP 1,0,5
wait 3
tc2_asyncq send RAMP 1,0,5
wait 3

tc1_asyncq send SETP 1,280
wait 3
tc2_asyncq send SETP 1,280
wait 3

sampletitle cooldown
RadCollTimed 1 120


