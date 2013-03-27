

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
	title Eu0.5Ba0.5TiO3 50K
	RunT 50 0 30
	title Eu0.5Ba0.5TiO3 75K
	RunT 75 900 30
	title Eu0.5Ba0.5TiO3 100K
	RunT 100 900 30
	title Eu0.5Ba0.5TiO3 125K
	RunT 125 900 30
	title Eu0.5Ba0.5TiO3 150K
	RunT 150 900 30
	title Eu0.5Ba0.5TiO3 160K
	RunT 160 900 30
	title Eu0.5Ba0.5TiO3 170K
	RunT 170 900 30
	title Eu0.5Ba0.5TiO3 180K
	RunT 180 900 30
	title Eu0.5Ba0.5TiO3 190K
	RunT 190 900 30
	title Eu0.5Ba0.5TiO3 200K
	RunT 200 900 30
	title Eu0.5Ba0.5TiO3 210K
	RunT 210 900 30
	title Eu0.5Ba0.5TiO3 220K
	RunT 220 900 30
	title Eu0.5Ba0.5TiO3 250K
	RunT 250 900 30
	title Eu0.5Ba0.5TiO3 275K
	RunT 275 900 30
	title Eu0.5Ba0.5TiO3 300K
	RunT 300 900 30
	title Eu0.5Ba0.5TiO3 base (11K - ish)
	RunT 5 3600 30
