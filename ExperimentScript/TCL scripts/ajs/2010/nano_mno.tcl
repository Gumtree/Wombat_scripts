

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
	title Nano-MnO base 0K
	RunT 0 10 11 30
	title Nano-MnO  20K
	RunT 20 600 11 30
	title Nano-MnO  50K
	RunT 50 900 11 30
	title Nano-MnO 100K
	RunT 100 1800 11 30
	title Nano-MnO 150K
	RunT 150 1800 11 30
	title Nano-MnO 300K
	RunT 300 3600 11 30
	