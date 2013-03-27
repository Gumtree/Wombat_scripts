#user "ajs/saerbeck"
#email "ajs@ansto.gov.au"
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




title Steel 1480C sample2 rotation

samplename Fe 0.05C
sampletitle 
sampledescription 

user ajs/kdl/Mark Reid
email ajs or kdl@ansto.gov.au

#running a fixed time
#SimpleRun 180 1

#scaning a motor
Scan3D som -70 0.5 200 3

#proc ::histogram_memory::pre_count {} {}




