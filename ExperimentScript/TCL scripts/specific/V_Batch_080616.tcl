sampledescription Vn standard rod 
samplename Vn 
sampletitle Vn standard for detector calibration 2.41A 968x128

#configure instrument to energy 1.54A
# V collection
title Vn 2.41A calibration 90/44.00 + 9.4 (113) 080618
histmem mode time
histmem preset 10800
for {set i 0} {$i < 1} {incr i} {
newfile HISTOGRAM_XYT
histmem start block
save
}
sampledescription bcg for Vn
samplename none
sampletitle bcg for Vn standard for detector calibration 1.54A

#configure instrument to energy 2.41A
# background
title Vn 2.41A calibration background 90/44.00 + 9.4 (113) 080618 
drive sphi -10
drive sphi 0


histmem mode time
histmem preset 10800
for {set i 0} {$i < 3} {incr i} {
newfile HISTOGRAM_XYT
histmem start block
save
}
