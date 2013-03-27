

title BNT RT-700K-RT
sampledescription 
sampletitle BNT
samplename mtth 90 Ge 113 2.41A
user Liu / ajs
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
tc1 upperlimit 730
tc2 upperlimit 730

tc1_asyncq send RAMP 1,0,5.2
wait 3
tc1_asyncq send SETP 1,800
wait 3
tc1_asyncq send RAMP 1,1,5.2
wait 3
tc2_asyncq send RAMP 1,0,5.2
wait 3
tc2_asyncq send SETP 1,800
wait 3
tc2_asyncq send RAMP 1,1,5.2
wait 3

#base temp
sampletitle hold 10 mins at ~300K
RadCollRampCF1 800 -5 100 1



sampletitle ramp to 300K
RadCollTimed 500 -5 100 2



#turn ramp off
tc1_asyncq send RAMP 1,0,2.4
wait 3
tc2_asyncq send RAMP 1,0,2.4
wait 3

tc1_asyncq send SETP 1,300
wait 3
tc2_asyncq send SETP 1,300
wait 3



