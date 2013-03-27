proc ::histogram_memory::pre_count {} {}

histmem mode time
histmem preset 20

#tc1 RampRate 800
#tc1 Setpoint 100

set bool 0
set tim1 [clock seconds]
while {$bool==0} { 
	histmem start block
	set tim2 [expr [clock seconds] -$tim1]
		if {$tim2 > 200} {set bool 1} 
}

#tc1 RampRate 10000
#tc1 Setpoint 0
			