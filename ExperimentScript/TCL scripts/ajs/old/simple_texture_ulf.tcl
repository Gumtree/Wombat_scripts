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
histmem preset 2
	
ephi speed 5
ephi accel 5
ephi maxretry 0

title Cu compressed 70/113 1.957A
sampledescription Cu texture standard
samplename Cu rod
user ajs / ulf
email ulf.garbe@ansto.gov.au

	title "Trip 78 Cr 70/113 1.957A chi 0 phi step 5deg"
	broadcast "Trip 78 Cr 70/113 1.957A chi 0"
	drive echi 0
	CollScan3D ephi -180 5 72	
	title "Trip 78 Cr 70/113 1.957A chi 15 phi step 5deg"
	broadcast "Trip 78 Cr 70/113 1.957A chi 15"
	drive echi 15
	CollScan3D ephi 180 -5 72	
	title "Trip 78 Cr 70/113 1.957A chi 30 phi step 5deg"
	broadcast "Trip 78 Cr 70/113 1.957A chi 30"
	drive echi 30
	CollScan3D ephi -180 5 72		
	title "Trip 78 Cr 70/113 1.957A chi 45 phi step 5deg"
	broadcast "Trip 78 Cr 70/113 1.957A chi 45"
	drive echi 45
	CollScan3D ephi 180 -5 72	
	title "Trip 78 Cr 70/113 1.957A chi 60 phi step 5deg"
	broadcast "Trip 78 Cr 70/113 1.957A chi 60"
	drive echi 60
	CollScan3D ephi -180 5 72	
	title "Trip 78 Cr 70/113 1.957A chi 75 phi step 5deg"
	broadcast "Trip 78 Cr 70/113 1.957A chi 75"
	drive echi 75
	CollScan3D ephi 180 -5 72	
	title "Trip 78 Cr 70/113 1.957A chi 90 phi step 5deg"
	broadcast "Trip 78 Cr 70/113 1.957A chi 90"
	drive echi 90
	CollScan3D ephi -180 5 72	

proc ::histogram_memory::pre_count {} {}
