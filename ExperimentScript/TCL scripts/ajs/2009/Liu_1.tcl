

title BNTBT in CF3 1500Vpp temp run
sampledescription BNTBT
sampletitle BNTBT
samplename mtth 90 Ge 113 2.41A
user Liu / Noren / ajs
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
tc1 controlsensor sensorC
tc2 controlsensor sensorD
tc1 range 5
tc2 range 5

tc1_asyncq send RAMP 1,0,5.0
wait 3
tc1_asyncq send SETP 1,300
wait 3
tc1_asyncq send RAMP 1,1,5.0
wait 3
tc2_asyncq send RAMP 1,0,5.0
wait 3
tc2_asyncq send SETP 1,300
wait 3
tc2_asyncq send RAMP 1,1,5.0
wait 3

histmem_period_strobo 1 16
wait 1800
sampletitle 300K strobo run 
RadCollRun 10 11

tc1_asyncq send SETP 1,350
wait 3
tc2_asyncq send SETP 1,350
wait 3

wait 1200

sampletitle 350K strobo run 
RadCollRun 10 11

tc1_asyncq send SETP 1,400
wait 3
tc2_asyncq send SETP 1,400
wait 3

wait 1200

sampletitle 400K strobo run 
RadCollRun 10 11

tc1_asyncq send SETP 1,450
wait 3
tc2_asyncq send SETP 1,450
wait 3

wait 1200

sampletitle 450K strobo run 
RadCollRun 10 11

tc1_asyncq send SETP 1,500
wait 3
tc2_asyncq send SETP 1,500
wait 3

wait 1200

sampletitle 500K strobo run 
RadCollRun 10 11

tc1_asyncq send SETP 1,550
wait 3
tc2_asyncq send SETP 1,550
wait 3

wait 1200

sampletitle 550K strobo run 
RadCollRun 10 11

tc1_asyncq send SETP 1,600
wait 3
tc2_asyncq send SETP 1,600
wait 3

wait 1200

sampletitle 600K strobo run 
RadCollRun 10 11


