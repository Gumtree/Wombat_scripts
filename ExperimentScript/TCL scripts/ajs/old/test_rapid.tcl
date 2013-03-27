# proc to set up rad coll OFF

proc ::histogram_memory::pre_count {} {
#        global oct_cycles
}


# note assume frame_frequency is 50Hz
proc rapidon {steptime numsteps} {
	set Nf [expr [$steptime*50]]
	FAT_TABLE -set NOS_PERIODS $numsteps
	BAT_TABLE -set PERIOD_INDICES {0 1} NO_BAT ENTRIES $numsteps
	BAT_TABLE -set NO_BAT_PERIODS $numsteps
	BAT_TABLE -set NO_REPEAT_ENTRY $Nf NO_REPEAT_TABLE 1 NO EXECUTE TABLE 1
}

proc rapidoff {} {
	FAT_TABLE -set NOS_PERIODS 1
	BAT_TABLE -clear
}	

proc rapidacq {steptime numsteps} {
	proc rapidon $steptime $numsteps
	newfile HISTOGRAM_XYT scratch
	histmem start block
	
	hmm configure read_data_period_number 	
	for {set i 0} {$i <$numsteps} {incr i} {
		hmm configure read_data_period_number $n
		save $n
	}
}	

#title 17-4 PH heat to 1360
title test rapid acq
sampletitle 
samplename 
user ajs
email ajs@ansto.gov.au

rapidacq 0.5 10
rapidoff


# uncomment this to kill rad coll
proc ::histogram_memory::pre_count {} {}
