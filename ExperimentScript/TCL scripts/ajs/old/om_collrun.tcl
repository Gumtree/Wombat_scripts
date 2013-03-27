# proc to set up rad coll

proc ::histogram_memory::pre_count {} {
#        global oct_cycles
        oscmd start 1
}



proc CollScan3D {motor start step numsteps} {
	
	histmem mode unlimited
#	histmem preset $steptime
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
#set oct_cycles 1
oct speed $spd
oct accel $spd
oct maxretry 0
drive oct 1.0


title Ba(FeCo)As2 in fridge rt 1min coll scan
sampledescription single xtal 
samplename BaFe1.74Co0.26As2
user ajs /my
email ajs@ansto.gov.au

CollScan3D som -50 0.2 50
CollScan3D som -40 0.2 50
CollScan3D som -30 0.2 50
CollScan3D som -20 0.2 50
CollScan3D som -10 0.2 50
CollScan3D som -0 0.2 50
CollScan3D som 10 0.2 50
CollScan3D som 20 0.2 50
CollScan3D som 30 0.2 50

# uncomment this to kill rad coll
proc ::histogram_memory::pre_count {} {}
