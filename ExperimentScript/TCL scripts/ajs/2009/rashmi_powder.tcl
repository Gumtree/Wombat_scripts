

title Ru1222 Rashmi
sampledescription in CF1 
sampletitle Ru1222
samplename mtth 90 Ge 113 2.41A
user Rashmi / sjk / ajs
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
tc2 controlsensor sensorC
tc1 range 5
tc2 range 5
tc1 lowerlimit 0
tc2 lowerlimit 0
tc1 tolerance 50
tc2 tolerance 50
tc1 settle 0
tc2 settle 0
tc1 upperlimit 400
tc2 upperlimit 400

tc1_asyncq send RAMP 1,0,2.4
wait 3
tc1_asyncq send SETP 1,60
wait 3
tc1_asyncq send RAMP 1,1,2.4
wait 3
tc2_asyncq send RAMP 1,0,2.4
wait 3
tc2_asyncq send SETP 1,60
wait 3
tc2_asyncq send RAMP 1,1,2.4
wait 3


#base temp


drive tc1 60 tc2 60
sampletitle hold 120 mins at 60K
RadCollTimed 1 120

sampletitle ramp to 80K
RadCollRampCF1 62 2 10 1

drive tc1 80 tc2 80
sampletitle hold 120 mins at 80K
RadCollTimed 1 120

sampletitle ramp to 100K
RadCollRampCF1 82 2 10 1

drive tc1 100 tc2 100
sampletitle hold 120 mins at 100K
RadCollTimed 1 120

sampletitle ramp to 120K
RadCollRampCF1 102 2 10 1

drive tc1 120 tc2 120
sampletitle hold 120 mins at 120K
RadCollTimed 1 120

sampletitle ramp to 140K
RadCollRampCF1 122 2 10 1

drive tc1 140 tc2 140
sampletitle hold 120 mins at 140K
RadCollTimed 1 120

sampletitle ramp to 160K
RadCollRampCF1 142 2 10 1

drive tc1 160 tc2 160
sampletitle hold 120 mins at 160K
RadCollTimed 1 120

sampletitle ramp to 180K
RadCollRampCF1 162 2 10 1

drive tc1 180 tc2 180
sampletitle hold 120 mins at 180K
RadCollTimed 1 120





turn ramp off
tc1_asyncq send RAMP 1,0,1.2
wait 3
tc2_asyncq send RAMP 1,0,1.2
wait 3
tc1_asyncq send RELAY 2,2,1



