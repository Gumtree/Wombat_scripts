user "ajs"
email "ajs@ansto.gov.au"
phone "3602"
proc ::histogram_memory::pre_count {} {
#       global oct_cycles
        oscmd start 1
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

set spd [expr 4.0/35]
oct softlowerlim -1.5
oct softupperlim 1.5
#set oct_cycles 1
oct speed $spd
oct accel $spd
oct maxretry 0
drive oct 1.0
#histmem mode time
#histmem preset 5

title bcg for CuSe
samplename CuSe single xtal
sampletitle CuSe single xtal)
sampledescription CuSe single xtal
user ajs
email ajs@ansto.gov.au
SimpleRun 10
#Scan3D mf2 0 0.05 11 10
#Scan3D eom 10 0.2 30



#proc ::histogram_memory::pre_count {} {}




