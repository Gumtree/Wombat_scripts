
sampletitle nothing
sampledescription 
samplename
title test collimator run

oct speed 0.2

drive oct -1
oct speed 0.035

histmem mode time
# reset 120
histmem preset 30
newfile HISTOGRAM_XY
histmem start
# reset to 1
drive oct -0.5
wait 1
drive oct -1
save




