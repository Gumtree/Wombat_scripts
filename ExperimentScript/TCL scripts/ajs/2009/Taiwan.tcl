SetRadColl 60 2
wait 3600
wait 3600
wait 3600
wait 3600
wait 3600


title Cu0.1Fe0.9Se0.85 in cryofurnace 10-300K 
sampletitle 
samplename  Taiwan no2 mtth 120 Ge115 1.88A
user ajs / special proposal
email ajs@ansto.gov.au

SetRadColl 60 2

# this seems to work
# CHECK THIS FOR CF1/CF2
tc1 controlsensor sensorA
tc2 controlsensor sensorA
tc1_asyncq send RAMP 1,0,1.0
wait 3
tc1_asyncq send SETP 1,10
wait 3
tc1_asyncq send RAMP 1,1,1.0
wait 3
tc2_asyncq send RAMP 1,0,1.0
wait 3
tc2_asyncq send SETP 1,10
wait 3
tc2_asyncq send RAMP 1,1,1.0
wait 3
tc1 range 5
tc2 range 5
tc1 tolerance 400
tc2 tolerance 400
tc1 settle 0
tc2 settle 0


proc RadCollRampCF1 {start step numsteps oscno} {

	RadCollOn $oscno
	histmem mode unlimited
	newfile HISTOGRAM_XY
	for {set i 0} {$i < $numsteps} {incr i} {
		set j [expr $i*$step+$start]
		drive tc1 $j tc2 $j
		histmem start block
		save $i
	}
	RadCollOff
}

#300K
sampletitle ramp 300
RadCollRampCF1 10 1 300 1


#turn ramp off
tc1_asyncq send RAMP 1,0,1.0
wait 3
tc2_asyncq send RAMP 1,0,1.0
wait 3
drive tc1 300 tc2 300
tc1_asyncq send RELAY 2,2,1
