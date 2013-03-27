

title Nano-MnO 10-300K
sampledescription Nano-MnO 10-300K
samplename mtth 95 Ge 113 2.51A
sampletitle Nano-MnO 10-300K
user W H Li Taiwan
email ajs@ansto.gov.au


SetRadColl 60 2

proc RunT {temp delay numsteps oscno} {
	hset /sample/tc1/sensor/setpoint1 $temp
	hset /sample/tc1/sensor/setpoint2 $temp
	wait $delay
	newfile HISTOGRAM_XY
	for {set i 0} {$i < $numsteps} {incr i} {	
		oscmd start $oscno
		hmm countblock
		save $i
	}
}
	title Nano-MnO bcg 15 min!
	RunT 300 10 2 15
	