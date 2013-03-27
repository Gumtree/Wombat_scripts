
set oct_cycles 1
#
proc ::histogram_memory::pre_count {} {
        global oct_cycles
        oscmd start $oct_cycles
}


set oct_cycles 5
histmem start block
# or runscan


proc ::histogram_memory::pre_count {} {}
