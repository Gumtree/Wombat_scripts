#instrument at energy 1
# V collection
histmem mode time
histmem preset 21600
for {set i 0} {$i < 1} {incr i} {
newfile HISTOGRAM_XYT
histmem start block
save
}
#configure instrument to energy 2
# V collection
drive mom 44.2 
drive mchi 89.3
histmem mode time
histmem preset 21600
for {set i 0} {$i < 1} {incr i} {
newfile HISTOGRAM_XYT
histmem start block
save
}

#configure instrument to energy 1
# background
drive mom 53.405 
drive mchi 89.6
drive sy -19
drive schi 90
histmem mode time
histmem preset 21600
for {set i 0} {$i < 2} {incr i} {
newfile HISTOGRAM_XYT
histmem start block
save
}

#configure instrument to energy 2
# background
drive mom 44.2
drive mchi 89.3
histmem mode time
histmem preset 21600
for {set i 0} {$i < 2} {incr i} {
newfile HISTOGRAM_XYT
histmem start block
save
}