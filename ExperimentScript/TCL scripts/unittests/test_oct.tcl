sampledescription test bcg with oct motor
samplename test bcg with oct motor
sampletitle test bcg with oct motor
title test bcg with oct motor
histmem mode time
histmem preset 30
newfile HISTOGRAM_XYT
histmem start noblock


for {set i 0} {$i <10} {incr i} {

drive oct 2
drive oct -2
}
save

