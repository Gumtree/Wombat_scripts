sampledescription Vn standard rod test
samplename Vn test
sampletitle Vn standard for detector calibration 1.54A test

#configure instrument to energy 1.54A
# V collection
title test histo save 
histmem mode time
histmem preset 10
for {set i 0} {$i < 1} {incr i} {
newfile HISTOGRAM_XYT
histmem start block
save
}
