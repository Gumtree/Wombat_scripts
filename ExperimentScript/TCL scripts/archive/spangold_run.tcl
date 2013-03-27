sampledescription spangold vert 2min sphi scans
samplename spangold 1.54A
sampletitle Au7Cu5.3Al3.7
title span gold 120sec sphi scan heated cubic

histmem mode time
histmem preset 120
newfile HISTOGRAM_XYT
for {set i 0} {$i <5} {incr i} {
drive sphi [expr $i*5-10]
histmem start block
save $i
}