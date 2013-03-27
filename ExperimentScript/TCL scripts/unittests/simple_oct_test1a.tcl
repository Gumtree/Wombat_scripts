proc ::histogram_memory::pre_count {} {
        global oct_cycles
        oscmd start $oct_cycles
}

oct softlowerlim -1
oct softupperlim 1
oct speed 0.05
oct accel 0.05
histmem mode unlimited
set oct_cycles 3
for {set i 0} {$i < 3} {incr i} {
	histmem start block
}

# uncomment this to kill rad coll
 proc ::histogram_memory::pre_count {} {}
