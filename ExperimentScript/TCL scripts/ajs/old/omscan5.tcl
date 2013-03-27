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
		
	for {set i 0} {$i <$numsteps} {incr i} {
		drive $motor [expr $i*$step+$start]
		histmem start block
	save $i
	}
}

title si wafer sacn mom and som
samplename si
sampletitle 
sampledescription 
user ajs
email ajs@ansto.gov.au
#SimpleRun 3600 18
newfile HISTOGRAM_XY
for {set j 0} {$j < 10} {incr j} {
	drive mom [expr $j*0.2+43]
	Scan3D som 35.5 0.1 31 10
}
#Scan3D ephi 119 0.1 20 5
#Scan3D som 60 0.2 200 5



#proc ::histogram_memory::pre_count {} {}




