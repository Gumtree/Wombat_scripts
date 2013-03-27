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




title name of exper here

samplename Al alloy B1006 #0702052
sampletitle 
sampledescription 

user ajs
email ajs@ansto.gov.au

#running a fixed time
#SimpleRun 180 1

#scaning a motor
Scan3D som -20 0.5 41 10

#proc ::histogram_memory::pre_count {} {}




