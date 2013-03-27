sampledescription test mult set
samplename test mult set
sampletitle test mult set
title test mult TAKE 2 set 1

hmm configure fat_multiple_datasets disable
histmem loadconf
wait 30

histmem mode time
histmem preset 10
newfile HISTOGRAM_XYT
for {set i 0} {$i <5} {incr i} {
histmem pause
drive stth [expr $i*1+20]
histmem start blocks

}
save 
histmem stop


title test mult TAKE 2 set 2

histmem mode time
histmem preset 10
newfile HISTOGRAM_XYT
for {set i 0} {$i <5} {incr i} {
histmem pause
drive stth [expr $i*1+20]
histmem start block

}
save
histmem stop
 