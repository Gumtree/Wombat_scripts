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
histmem preset 95
	
ephi speed 5
ephi accel 5
ephi maxretry 0

title Geo test 70/113 1.957A
sampledescription Geo test Texture
samplename Geo test
user ajs / ulf
email ulf.garbe@ansto.gov.au

	title "Geo test  2.1A chi 0 phi step 5deg"
	broadcast "Geo test 2.1A chi 0"
	drive echi 0
	CollScan3D ephi -180 5 72	
	title "Geo test 2.1A chi 15 phi step 5deg"
	broadcast "Geo test 2.1A chi 15"
	drive echi 15
	CollScan3D ephi 180 -5 72	
	title "Geo test 70/113 2.1A chi 30 phi step 5deg"
	broadcast "Geo test 70/113 2.1A chi 30"
	drive echi 30
	CollScan3D ephi -180 5 72		
	title "Geo test 70/113 2.1A chi 45 phi step 5deg"
	broadcast "Geo test 70/113 2.1A chi 45"
	drive echi 45
	CollScan3D ephi 180 -5 72	
	title "Geo test 70/113 2.1A chi 60 phi step 5deg"
	broadcast "Geo test 70/113 2.1A chi 60"
	drive echi 60
	CollScan3D ephi -180 5 72	
	title "Geo test 70/113 2.1A chi 75 phi step 5deg"
	broadcast "Geo test 70/113 2.1A chi 75"
	drive echi 75
	CollScan3D ephi 180 -5 72	
	title "Geo test 70/113 2.1A chi 90 phi step 5deg"
	broadcast "Geo test 70/113 2.1A chi 90"
	drive echi 90
	CollScan3D ephi -180 5 72	

proc ::histogram_memory::pre_count {} {}
