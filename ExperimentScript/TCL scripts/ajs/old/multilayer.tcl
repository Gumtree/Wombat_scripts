user "ajs/saerbeck"
email "ajs@ansto.gov.au"
phone "3602"
proc ::histogram_memory::pre_count {} {
#       global oct_cycles
        oscmd start 4
}

proc SimpleRun {numsteps} {
#	histmem mode time
	histmem mode unlimited
	newfile HISTOGRAM_XY
#	histmem preset $steptime
	for {set i 0} {$i < $numsteps} {incr i} {
		histmem start block
		save $i
	}
}

proc Scan3D {motor start step numsteps} {
	
#	histmem mode time
#	histmem preset $steptime
	histmem mode unlimited
	newfile HISTOGRAM_XY	
	for {set i 0} {$i <$numsteps} {incr i} {
		drive $motor [expr $i*$step+$start]
		histmem start block
	save $i
	}
}

set spd [expr 4.0/60.0]
broadcast $spd
oct softlowerlim -1.5
oct softupperlim 1.5
oct speed $spd
oct accel $spd
oct maxretry 0
drive oct 1.0

title Co/CuMn 3K omega scan
tc1 tolerance 5
tc1 settle 300
drive tc1 3
samplename Co / CuMn on Si Thomas Saerbeck fixed coll
sampletitle Co / CuMn
sampledescription Co / CuMn

Scan3D som -1.5 0.1 90

drive som 13
SimpleRun 5

title Co/CuMn 200K omega scan

tc1 settle 900
drive tc1 200

Scan3D som -1.5 0.1 90

proc ::histogram_memory::pre_count {} {}




