# proc to set up rad coll

proc ::histogram_memory::pre_count {} {}
#        global oct_cycles
#       oscmd start 1

proc CollScan3D {motor start step numsteps} {
	
#	histmem mode unlimited

	newfile HISTOGRAM_XY	
	for {set i 0} {$i <$numsteps} {incr i} {
		drive $motor [expr $i*$step+$start]
		histmem start block
	save $i
	}
}

histmem mode time
histmem preset 300
	
ephi speed 5
ephi accel 5
ephi maxretry 0

title TiAl 70/113 1.957A
sampledescription TiAl texture 
samplename TiAl HH-Test
user ajs / ulf
email ulf.garbe@ansto.gov.au

	title "Leer test 70/113 1.957A chi 0 phi step 5deg"
	broadcast "Leer test 70/113 1.957A chi 0"
	drive echi 0
	CollScan3D ephi -180 5 1	


proc ::histogram_memory::pre_count {} {}
