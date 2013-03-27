# proc to set up rad coll

proc ::histogram_memory::pre_count {} {
#        global oct_cycles
       oscmd start 1
}
proc CollAxisScan {motor start step numsteps} {

	newfile HISTOGRAM_XY
	for {set i 0} {$i <$numsteps} {incr i} {
		drive $motor [expr $i*$step+$start]
		histmem start block
		save $i
	}
}	

eom softlowerlim -43.5
eom softupperlim 45.5
set spd [expr 4.0/35]
oct softlowerlim -1.5
oct softupperlim 1.5
oct speed $spd
oct accel $spd
oct maxretry 0
drive oct 1.0


samplename bcg for Cu1.8Se xtal
sampledescription none
sampletitle none

title bcg for Cu1.8Se scan

#drive echi 0

CollAxisScan ephi 0 0.2 20
#CollAxisScan ephi -70 0.2 150
#CollAxisScan ephi -40 0.2 150
#CollAxisScan ephi -10 0.2 150

#drive ephi -35.4

#title Cu1.8Se scan echi 111 35.26 deg 90 deg scan
#drive echi 35.26

#CollAxisScan eom -43 0.2 140
#CollAxisScan eom -15 0.2 150
#CollAxisScan eom 15 0.2 150

#title Cu1.8Se scan echi h00 90.00 deg 
#drive echi 90.00

#CollAxisScan eom -43 0.2 140
#CollAxisScan eom -15 0.2 150
#CollAxisScan eom 15 0.2 150

#title Cu1.8Se scan echi 112 54.73 deg 
#drive echi 54.73

#CollAxisScan eom -43 0.2 140
#CollAxisScan eom -15 0.2 150
#CollAxisScan eom 15 0.2 150


# uncomment this to kill rad coll
proc ::histogram_memory::pre_count {} {}
