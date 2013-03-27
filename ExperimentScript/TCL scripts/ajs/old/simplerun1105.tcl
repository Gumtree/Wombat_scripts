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

title scan mf2 for al2o3 at 90deg
samplename al2o3
sampletitle 
sampledescription 
user ajs
email ajs@ansto.gov.au
#SimpleRun 3600 18
Scan3D som 35.5 0.1 21 10
#Scan3D ephi 119 0.1 20 5
#Scan3D som 60 0.2 200 5



#proc ::histogram_memory::pre_count {} {}




