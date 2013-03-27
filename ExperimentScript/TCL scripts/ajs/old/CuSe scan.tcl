# proc to set up rad coll

proc ::histogram_memory::pre_count {} {
#        global oct_cycles
#       oscmd start 1
}
proc CollAxisScan {motor start step numsteps} {

	newfile HISTOGRAM_XY
	for {set i 0} {$i <$numsteps} {incr i} {
		drive $motor [expr $i*$step+$start]
		histmem start block
		save $i
	}
}	

eom softlowerlimit -43.5
eom softupperlimit 45

histmem mode time
histmem preset 22

samplename Cu1.8Se xtal
sampledescription copper selenide
sampletitle Cu1.8Se xtal

title Cu1.8Se scan hk0 plane 180deg

drive echi 0

CollAxisScan ephi -97.2 0.1 300
CollAxisScan ephi -67.2 0.1 300
CollAxisScan ephi -37.2 0.1 300
CollAxisScan ephi -7.2 0.1 300
CollAxisScan ephi 22.8 0.1 300
CollAxisScan ephi 52.8 0.1 300

drive ephi 37.8

title Cu1.8Se scan echi 441 10.02 deg 
drive echi 10.02

CollAxisScan eom -43 0.1 280
CollAxisScan eom -15 0.1 300
CollAxisScan eom 15 0.1 300

title Cu1.8Se scan echi 221 19.47 deg 
drive echi 19.47

CollAxisScan eom -43 0.1 280
CollAxisScan eom -15 0.1 300
CollAxisScan eom 15 0.1 300

title Cu1.8Se scan echi 111 35.26 deg 
drive echi 35.26

CollAxisScan eom -43 0.1 280
CollAxisScan eom -15 0.1 300
CollAxisScan eom 15 0.1 300

title Cu1.8Se scan echi 223 46.68 deg 
drive echi 46.68

CollAxisScan eom -43 0.1 280
CollAxisScan eom -15 0.1 300
CollAxisScan eom 15 0.1 300

title Cu1.8Se scan echi 112 54.73 deg 
drive echi 54.73

CollAxisScan eom -43 0.1 280
CollAxisScan eom -15 0.1 300
CollAxisScan eom 15 0.1 300

title Cu1.8Se scan echi 114 70.52 deg 
drive echi 70.52

CollAxisScan eom -43 0.1 280
CollAxisScan eom -15 0.1 300
CollAxisScan eom 15 0.1 300

title Cu1.8Se scan echi 118 80.00 deg 
drive echi 80.00

CollAxisScan eom -43 0.1 280
CollAxisScan eom -15 0.1 300
CollAxisScan eom 15 0.1 300

title Cu1.8Se scan echi h00 90.00 deg 
drive echi 90.00

CollAxisScan eom -43 0.1 280
CollAxisScan eom -15 0.1 300
CollAxisScan eom 15 0.1 300


# uncomment this to kill rad coll
#proc ::histogram_memory::pre_count {} {}
