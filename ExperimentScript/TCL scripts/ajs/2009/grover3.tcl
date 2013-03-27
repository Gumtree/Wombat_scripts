

title Nd0.8Tb0.2Al2 in CF4 magnet 0-110K 4T 
sampledescription Nd0.8Tb0.2Al2
samplename mtth 90 Ge 113 2.41A
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
	tc1_asyncq send RAMP 1,0,2.4
	wait 3
	tc1_asyncq send SETP 1,0
	wait 3
	tc1_asyncq send RAMP 1,1,2.4
	wait 3
	tc1_asyncq send RAMP 2,0,2.4
	wait 3
	tc1_asyncq send SETP 2,0
	wait 3
	tc1_asyncq send RAMP 2,1,2.4
	wait 3
}

#bug in sensor 1: occasionally trips out


SetRadColl 60 2
tc1 controlsensor sensorB
tc1 range 5


sampletitle ramp to 110K at 2K/min
TempReset
RadCollRampCF1 0 2 110 1
