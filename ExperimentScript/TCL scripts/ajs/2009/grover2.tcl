

title Nd0.8Tb0.2Al2 in CF4 magnet 0-110K 0T
sampledescription Nd0.8Tb0.2Al2
samplename mtth 90 Ge 115 1.49AA
user ajs /grover / mona
email ajs@ansto.gov.au

proc RadCollRampCF1 {start step numsteps oscno} {
	
	histmem mode unlimited
	newfile HISTOGRAM_XY
	for {set i 0} {$i < $numsteps} {incr i} {
		set j [expr $i*$step+$start]
		tc1_asyncq send SETP 1,$j
	    tc1_asyncq send SETP 2,$j
		oscmd start $oscno
		hmm countblock
		save $i
	}
	oscmd stop
}



proc TempReset {} {
	tc1_asyncq send RAMP 1,0,1.2
	wait 3
	tc1_asyncq send SETP 1,0
	wait 3
	tc1_asyncq send RAMP 1,1,1.2
	wait 3
	tc1_asyncq send RAMP 2,0,1.2
	wait 3
	tc1_asyncq send SETP 2,0
	wait 3
	tc1_asyncq send RAMP 2,1,1.2
	wait 3
}

#bug in sensor 1: occasionally trips out


SetRadColl 60 2
tc1 controlsensor sensorB
tc1 range 5

wait 1800
wait 3600
wait 3600
wait 3600
wait 3600
wait 3600
wait 3600


sampletitle ramp to 110K
TempReset
RadCollRampCF1 0 1 110 1

TempReset
wait 1400
magnet send s 2
wait 180
title Nd0.8Tb0.2Al2 in CF4 magnet  0-110K 0.5T
RadCollRampCF1 0 1 110 1

TempReset
wait 1400
magnet send s 4
wait 180
title Nd0.8Tb0.2Al2 in CF4 magnet  0-110K 1.0T
RadCollRampCF1 0 1 110 1

TempReset
wait 1400
magnet send s 8
wait 300
title Nd0.8Tb0.2Al2 in CF4 magnet  0-110K 2.0T
RadCollRampCF1 0 1 110 1

tc1_asyncq send RELAY 2,2,1
tc1_asyncq send RAMP 1,0,1.2
wait 3
tc1_asyncq send RAMP 2,0,1.2
wait 3
tc1_asyncq send SETP 1,300
wait 3
tc1_asyncq send SETP 2,300
wait 3
