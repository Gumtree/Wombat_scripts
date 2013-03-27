

title NdMn2Ge0.4Si1.6 CF1 15 deg steps
sampledescription 
sampletitle NdMn2Ge0.4Si1.6
samplename mtth 90 Ge 113 2.41A
user Wang / Campbell / Cadogan / ajs
email ajs@ansto.gov.au

proc RadCollRampCF1 {start step numsteps oscno} {
	tc1_asyncq send SETP 1,$start
	tc2_asyncq send SETP 1,$start
	histmem mode unlimited
	newfile HISTOGRAM_XY
	for {set i 0} {$i < $numsteps} {incr i} {
		set j [expr $i*$step+$start+1]
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
tc1 lowerlimit 0
tc2 lowerlimit 0
tc1 tolerance 50
tc2 tolerance 50
tc1 settle 0
tc2 settle 0

tc1_asyncq send RAMP 1,0,1.2
wait 3
tc1_asyncq send SETP 1,0
wait 3
tc1_asyncq send RAMP 1,1,1.2
wait 3
tc2_asyncq send RAMP 1,0,1.2
wait 3
tc2_asyncq send SETP 1,0
wait 3
tc2_asyncq send RAMP 1,1,1.2
wait 3


#base temp
sampletitle hold 40 mins at ~6K
RadCollTimed 1 40


for {set kx 0} {$kx < 31} {incr kx} {
		set ky [expr $kx*15]
		sampletitle ramp from $ky
		RadCollRampCF1 $ky 1 15 1
		set kz [expr $ky+15]
		sampletitle hold 20 mins at $kz
		drive tc1 $kz tc2 $kz
		RadCollTimed 1 20
}


#turn ramp off
tc1_asyncq send RAMP 1,0,1.0
wait 3
tc2_asyncq send RAMP 1,0,1.0
wait 3
tc1_asyncq send RELAY 2,2,1
drive tc1 300 tc2 300

