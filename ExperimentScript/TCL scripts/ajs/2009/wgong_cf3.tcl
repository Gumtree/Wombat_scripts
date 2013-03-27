

title "Bi0.8La0.2Fe0.94Nb0.01Ni0.05O3"
sampledescription 
sampletitle BLNFCo wgong sample 5
samplename mtth 90 Ge 115 1.54A
user Zhenxiang Cheng Wgong
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
tc1 upperlimit 760
tc2 upperlimit 760

tc1_asyncq send RAMP 1,0,1.2
wait 3
tc1_asyncq send SETP 1,300
wait 3
tc1_asyncq send RAMP 1,1,6
wait 3
tc2_asyncq send RAMP 1,0,1.2
wait 3
tc2_asyncq send SETP 1,300
wait 3
tc2_asyncq send RAMP 1,1,6
wait 3

#base temp
sampletitle hold 1 min at ~300K
RadCollRun 1 1

sampletitle ramp to 550K at 5K/min
RadCollRampCF1 300 5 50 1

tc1_asyncq send SETP 1,550
wait 3
tc2_asyncq send SETP 1,550
wait 3
tc1_asyncq send RAMP 1,1,1.2
wait 3
tc2_asyncq send RAMP 1,1,1.2
wait 3

sampletitle hold at 550K
RadCollTimed 1 1

sampletitle ramp to 750K
RadCollRampCF1 550 1 200 1



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



