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
histmem preset 20
	
ephi speed 5
ephi accel 5
ephi maxretry 0

title Cu compressed 70/113 1.957A
sampledescription Cu texture -compressed
samplename Cu rod
user ajs / ulf
email ulf.garbe@ansto.gov.au

for {set j 0} {$j <7} {incr j} {
	title "Cu small cylinder 70/113 1.957A chi [expr $j*15] phi step 5deg"
	broadcast "Cu standard 70/113 1.957A chi [expr $j*15]"
	drive echi [expr $j*15]
	CollScan3D ephi -180 5 72	
}

proc ::histogram_memory::pre_count {} {}
