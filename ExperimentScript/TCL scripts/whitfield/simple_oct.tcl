# proc to set up rad coll

proc ::histogram_memory::pre_count {} {
        global oct_cycles
        oscmd start $oct_cycles
}


set spd [expr 4.0/60.0]
broadcast $spd
oct softlowerlim -1.5
oct softupperlim 1.5

oct speed $spd
oct accel $spd
oct maxretry 0
drive oct 1.0


title vac furn at 100deg with sample test 
sampledescription pre-sintered steel
samplename 17-4 PH
sampletitle furnace with sample test change tilt angle

user Ross Whitfield / Darren Goossens / ajs
email u4133815@anu.edu.au

histmem mode unlimited
newfile HISTOGRAM_XY	
set oct_cycles 1
histmem start block
save

# uncomment this to kill rad coll
proc ::histogram_memory::pre_count {} {}
