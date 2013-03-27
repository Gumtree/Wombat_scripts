

title Eu0.5Ba0.5TiO3 10-300K
sampledescription Eu0.5Ba0.5TiO3 in CF1 10-300K 
samplename mtth 70 Ge 115 1.249A
sampletitle Eu0.5Ba0.5TiO3 10-300K
user "mona / ajs"
email ajs@ansto.gov.au


SetRadColl 60 2

proc RunT {temp delay numsteps} {
	hset /sample/tc1/sensor/setpoint1 $temp
	hset /sample/tc2/sensor/setpoint1 $temp  
	wait $delay
	newfile HISTOGRAM_XY
	for {set i 0} {$i < $numsteps} {incr i} {	
		oscmd start 15
		hmm countblock
		save $i
	}
}
	title Eu0.5Ba0.5TiO3 base (10K)
	RunT 5 1 30
	title Eu0.5Ba0.5TiO3 base (140K)
	RunT 140 3600 30
	title Eu0.5Ba0.5TiO3 base (260K)
	RunT 260 3600 30
	