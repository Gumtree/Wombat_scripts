

title Ru_1212 ramp magnet 0-6 T @0.02T/min, 10 K
sampledescription Ru1212
samplename mtth 90 Ge 113 2.41A
user rashmi / sjk
email sjk@ansto.gov.au

proc RadCollRampCF1 {start step numsteps oscno} {
	
	histmem mode unlimited
	newfile HISTOGRAM_XY
	for {set i 0} {$i < $numsteps} {incr i} {
		set j [expr $i*$step+$start]
		tc1_asyncq send SETP 1,$j
	    tc1_asyncq send SETP 2,$j
	    tc1 range 5
		oscmd start $oscno
		hmm countblock
		save $i
	}
	oscmd stop
}


proc TempReset {temp rate} {
	tc1_asyncq send RAMP 1,0,$rate
	wait 3
	tc1_asyncq send SETP 1,$temp
	wait 3
	tc1_asyncq send RAMP 1,1,$rate
	wait 3
	tc1_asyncq send RAMP 2,0,$rate
	wait 3
	tc1_asyncq send SETP 2,$temp
	wait 3
	tc1_asyncq send RAMP 2,1,$rate
	wait 3
}

proc SetTemp {temp} {

   tc1_asyncq send SETP 1,$temp
   wait 3
   tc1_asyncq send SETP 2,$temp
   wait 3
   tc1 range 5
}

proc SetRamp {ramp} {

	tc1_asyncq send RAMP 1,1,$ramp
	wait 3
	tc1_asyncq send RAMP 2,1,$ramp
	wait 3
}

proc RampOff { } {
	tc1_asyncq send RAMP 1,0,1
	wait 3
	tc1_asyncq send RAMP 2,0,1
	wait 3
}

# standard boilerplate for start of run

SetRadColl 60 2
# tc1 controlsensor sensorB
tc1 controlsensor sensorD
tc1 range 5


# eg to set a ramp. 1st number is loop (you need 1 and 2)
# 2nd numer 1 means ramp 0 means ramp off
# 3rd number is ramp in K/min

#	tc1_asyncq send RAMP 1,1,2.4
#	wait 3
#	tc1_asyncq send RAMP 2,1,2.4
#	wait 3


# how to set a temperature eg to 20K
# you need both of these
#   tc1_asyncq send SETP 1,20
#   wait 3
#   tc1_asyncq send SETP 2,20
#   wait 3


# to set magnetic field eg 2T (really 1T)
#
# magnet send s 2.0
# 
# monitor with
# 
# magnet send ?






sampletitle Ru1212 
#TempReset 20 1.2
#RadCollRampCF1 20 1 141 4
#RampOff
SetTemp 300

#magnet send s 12
#RadCollRun 4 76