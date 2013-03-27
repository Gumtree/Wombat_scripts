user "ajs/saerbeck"
email "ajs@ansto.gov.au"
phone "3602"
proc ::histogram_memory::pre_count {} {
#       global oct_cycles
#        oscmd start 1
}

proc SimpleRun {steptime numsteps} {
	histmem mode time
	newfile HISTOGRAM_XY
	histmem preset $steptime
	for {set i 0} {$i < $numsteps} {incr i} {
		histmem start block
		save $i
	}
}

proc Scan3D {motor start step numsteps steptime} {
	
	histmem mode time
	histmem preset $steptime
	newfile HISTOGRAM_XY	
	for {set i 0} {$i <$numsteps} {incr i} {
		drive $motor [expr $i*$step+$start]
		histmem start block
	save $i
	}
}

title Co/CuMn test run for peak 004 again
samplename Co / CuMn on Si Thomas Saerbeck fixed coll
sampletitle Co / CuMn
sampledescription Co / CuMn
user ajs
email ajs@ansto.gov.au
SimpleRun 60 1
#Scan3D som 3 5 2 180
#Scan3D ephi 119 0.1 20 5
#Scan3D som 60 0.2 200 5



#proc ::histogram_memory::pre_count {} {}




