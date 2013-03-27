sampledescription Vn standard rod 
samplename Vn 
sampletitle Vn standard for detector calibration 2.41A 968x128

#configure instrument to energy 2.41A
# V collection
title Vn 2.41A calibration 90/44.00 + 9.4 (113) 080619

histmem mode time
histmem preset 700
newfile HISTOGRAM_XYT
for {set i 0} {$i <31} {incr i} {
drive stth [expr $i*0.5+15]
histmem start block
save $i
}

sampledescription bcg for Vn
samplename none
sampletitle bcg for Vn standard for detector calibration 2.41A

drive sphi -10
drive sphi 0

histmem mode time
histmem preset 700
newfile HISTOGRAM_XYT
for {set i 0} {$i <31} {incr i} {
drive stth [expr $i*0.5+15]
histmem start block
save $i
}