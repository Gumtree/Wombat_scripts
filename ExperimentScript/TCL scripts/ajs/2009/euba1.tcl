

sampletitle EuBaTiO3
sampledescription EuBaTiO3
samplename mtth 90 Ge 335 1.22A
user ajs / mona
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

	tc1_asyncq send RAMP 1,1,10
	wait 3
	tc1_asyncq send RAMP 2,1,10
	wait 3

SetRadColl 60 2
tc1 controlsensor sensorB
tc1 range 5

wait 3600
wait 1800

title Eu0.5Ba0.5TiO3 in CF4 base temp 4K

RadCollRun 30 1 

title Eu0.5Ba0.5TiO3 in CF4 10K
tc1_asyncq send SETP 1,10
tc1_asyncq send SETP 2,10
wait 180
RadCollRun 30 1
RadCollRun 30 1
 

title Eu0.5Ba0.5TiO3 in CF4 20K
tc1_asyncq send SETP 1,20
tc1_asyncq send SETP 2,20
wait 180
RadCollRun 30 1 

title Eu0.5Ba0.5TiO3 in CF4 30K
tc1_asyncq send SETP 1,30
tc1_asyncq send SETP 2,30
wait 180
RadCollRun 30 1 

title Eu0.5Ba0.5TiO3 in CF4 40K
tc1_asyncq send SETP 1,40
tc1_asyncq send SETP 2,40
wait 180
RadCollRun 30 1 

title Eu0.5Ba0.5TiO3 in CF4 50K
tc1_asyncq send SETP 1,50
tc1_asyncq send SETP 2,50
wait 180
RadCollRun 30 1 

title Eu0.5Ba0.5TiO3 in CF4 75K
tc1_asyncq send SETP 1,75
tc1_asyncq send SETP 2,75
wait 300
RadCollRun 30 1 

title Eu0.5Ba0.5TiO3 in CF4 100K
tc1_asyncq send SETP 1,100
tc1_asyncq send SETP 2,100
wait 300
RadCollRun 30 1 

title Eu0.5Ba0.5TiO3 in CF4 150K
tc1_asyncq send SETP 1,150
tc1_asyncq send SETP 2,150
wait 400
RadCollRun 30 1 

title Eu0.5Ba0.5TiO3 in CF4 200K
tc1_asyncq send SETP 1,200
tc1_asyncq send SETP 2,200
wait 400
RadCollRun 30 1 

title Eu0.5Ba0.5TiO3 in CF4 250K
tc1_asyncq send SETP 1,250
tc1_asyncq send SETP 2,250
wait 400
RadCollRun 30 1 

title Eu0.5Ba0.5TiO3 in CF4 300K
tc1_asyncq send SETP 1,300
tc1_asyncq send SETP 2,300
wait 400
RadCollRun 30 1 
