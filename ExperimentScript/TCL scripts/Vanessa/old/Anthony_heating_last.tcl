user "vep"
email "vep@ansto.gov.au"
phone "9401"
#tc1 controlsensor sensorA
#tc2 controlsensor sensorA
#tc1 range 5
#tc2 range 5
# proc to set up rad coll

proc ::histogram_memory::pre_count {} {
#        global oct_cycles
        oscmd start 1
}


proc collect {time} {
	set tim1 [clock seconds]
	set bool 0
	histmem mode unlimited
	newfile HISTOGRAM_XY	

	set i 0
	while {$bool==0} {
		histmem start block
		save $i
		incr i
		set tim2 [expr [clock seconds]-$tim1]
		broadcast $tim2
		if {$tim2>$time*60} {set bool 1}
	}
}	
	
	
set spd [expr 4.0/60.0]

broadcast $spd
oct softlowerlim -1.5
oct softupperlim 1.5
#set oct_cycles 10
oct speed $spd
oct accel $spd
oct maxretry 0
#drive oct 1.0


#title "NC4D12CuZn(CN)4     420K"
#samplename "NC4D12CuZn(CN)4     420 K"
#drive tc1 420 tc2 420
#wait 1800
collect 30



title "NC4D12CuZn(CN)4     440K"
samplename "NC4D12CuZn(CN)4     440 K"
#drive tc1 440 tc2 440
#wait 1800
collect 30

#drive tc1 300 tc2 300

# uncomment this to kill rad coll
proc ::histogram_memory::pre_count {} {}
