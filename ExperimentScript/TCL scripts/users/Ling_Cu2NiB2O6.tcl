

title "Cu2NiB2O6 in cryostat restart" 
sampledescription "Cu2NiB2O6"
samplename "mtth 115 Ge 111 5.5096A"
user Chris Ling
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
tc1 controlsensor sensorA

tc1 range 5
tc1 tolerance 1
tc1 settle 300

tc1 lowerlimit 0


tc1_asyncq send RAMP 1,0,0.5
wait 3
tc1_asyncq send SETP 1,0
wait 3
tc1_asyncq send RAMP 1,1,0.5
wait 3


#base temp
#sampletitle "hold 40 mins at 1.8K"
#RadCollTimed 1 40

sampletitle "ramp to 20K at 1K/60min"
RadCollRampCF1 0 1 20 60






