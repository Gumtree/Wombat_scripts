

title TGS 060 scan 302-325K complete
sampledescription TGS
samplename mtth 70 Ge 113 1.95A
user ajs
email ajs@ansto.gov.au

proc RadCollRampCF1 {start step numsteps oscno} {
	
	histmem mode unlimited
	newfile HISTOGRAM_XY
	for {set i 0} {$i < $numsteps} {incr i} {
		set j [expr $i*$step+$start]
		tc1_asyncq send SETP 1,$j

		oscmd start $oscno
		hmm countblock
		save $i
	}
	oscmd stop
}

SetRadColl 60 2
tc1 controlsensor sensorC





tc1_asyncq send RAMP 2,1,1.2
wait 3

tc1_asyncq send SETP 2,300


sampletitle scan 060 at 300K
RadCollScan som 25 0.25 17 1

tc1_asyncq send SETP 2,310
wait 240

sampletitle scan 060 at 310K
RadCollScan som 25 0.25 17 1

tc1_asyncq send SETP 2,315
wait 300

sampletitle scan 060 at 315K
RadCollScan som 25 0.25 17 1

tc1_asyncq send SETP 2,317
wait 120

sampletitle scan 060 at 317K
RadCollScan som 25 0.25 17 1

tc1_asyncq send SETP 2,319
wait 120

sampletitle scan 060 at 319K
RadCollScan som 25 0.25 17 1

tc1_asyncq send SETP 2,321
wait 120

sampletitle scan 060 at 321K
RadCollScan som 25 0.25 17 1

tc1_asyncq send SETP 2,323
wait 120

sampletitle scan 060 at 323K
RadCollScan som 25 0.25 17 1

tc1_asyncq send SETP 2,325
wait 120

sampletitle scan 060 at 325K
RadCollScan som 25 0.25 17 1
