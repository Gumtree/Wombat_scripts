

title coarse nano Tb in CF4 0-300K
sampletitle
samplename mtth 90 Ge 113 2.41A
user ajs / rr / michels
email ajs@ansto.gov.au

proc RadCollRampCF4 {start step numsteps oscno} {

	RadCollOn $oscno
	histmem mode unlimited
	newfile HISTOGRAM_XY
	for {set i 0} {$i < $numsteps} {incr i} {
		set j [expr $i*$step+$start]
		tc1_asyncq send SETP 1,$j

		histmem start block
		save $i
	}
	RadCollOff
}


SetRadColl 60 2
tc1 controlsensor sensorB
tc1 range 5

sampletitle hold 20 mins at ~290K
RadCollRun 1 20

#turn ramp off
#tc1_asyncq send RAMP 1,0,1.0
#wait 3
#tc2_asyncq send RAMP 1,0,1.0
#wait 3
#drive tc1 300 tc2 300
#tc1_asyncq send RELAY 2,2,1
