sampledescription Al2O3
samplename Al2O3 
sampletitle Al2O3 standard NBS
#configure instrument to energy 1.54A
# V collection
title Al2O3 scan mf2 to 0.7

histmem mode time
histmem preset 120
newfile HISTOGRAM_XYT
for {set i 0} {$i <15} {incr i} {
drive mf2 [expr $i*0.05]
histmem start block
save $i
}