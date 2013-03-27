sampledescription Vn standard
samplename Vn Standard 
sampletitle Vn Standard

hmm configure fat_multiple_datasets disable
histmem loadconf
wait 30

# V collection
# std histo config


title Vn 968x512 1.54 115
drive mom 43.9
histmem mode time
histmem preset 850
newfile HISTOGRAM_XYT
for {set i 0} {$i <10} {incr i} {
histmem pause
drive stth [expr $i*0.5+20]
histmem start block
}
save 
histmem stop

title Vn 968x512 1.21 335
drive mom 68.4
histmem mode time
histmem preset 640
newfile HISTOGRAM_XYT
for {set i 0} {$i <10} {incr i} {
histmem pause
drive stth [expr $i*0.5+20]
histmem start block
}
save 
histmem stop

title Vn 968x512 2.41 113
drive mom 53.4
histmem mode time
histmem preset 1280
newfile HISTOGRAM_XYT
for {set i 0} {$i <10} {incr i} {
histmem pause
drive stth [expr $i*0.5+20]
histmem start block
}
save 
histmem stop

hmm configure fat_multiple_datasets enable
histmem loadconf
wait 30

title Vn 968x512 2.41 113 scan intensity
histmem mode time
histmem preset 120
newfile HISTOGRAM_XYT
CRASHED HERE
for {set i 0} {$i <4} {incr i} {
drive mom [expr $i*0.2+53.0]
histmem start block
save $i

# big histo config

oat_table -set X {991.5 990.5} Y {-0.5 0.5} T {0 20000}
oat_table -set NXC 992 NYC 512 NTC 1
fat_table -set MULTI_HOST_HISTO_STITCH_OVERLAP 32
histmem loadconf
wait 120

hmm configure fat_multiple_datasets disable
histmem loadconf
wait 30

title Vn 3872x512 2.41 113
drive mom 53.4 
histmem mode time
histmem preset 3900
newfile HISTOGRAM_XYT
for {set i 0} {$i <10} {incr i} {
histmem pause
drive stth [expr $i*0.5+20]
histmem start block
}
save 
histmem stop

title Vn 3872x512 1.54 115
drive mom 43.9 
histmem mode time
histmem preset 10
newfile HISTOGRAM_XYT
for {set i 0} {$i <10} {incr i} {
histmem pause
drive stth [expr $i*0.5+20]
histmem start block
}
save 
histmem stop

# background collection
# big histo config

sampledescription bcg
samplename bcg 
sampletitle bcg

drive sphi -10
drive sphi 0

title Vn bcg 3872x512 2.41 113
drive mom 53.4 
histmem mode time
histmem preset 3900
newfile HISTOGRAM_XYT
for {set i 0} {$i <10} {incr i} {
histmem pause
drive stth [expr $i*0.5+20]
histmem start block
}
save 
histmem stop

title Vn bcg 3872x512 1.54 115
drive mom 43.9 
histmem mode time
histmem preset 10
newfile HISTOGRAM_XYT
for {set i 0} {$i <10} {incr i} {
histmem pause
drive stth [expr $i*0.5+20]
histmem start block
}
save 
histmem stop



# background collection
# std histo config

oat_table -set X {991.5 987.5} Y {-0.5 3.5} T {0 20000}
oat_table -set NXC 248 NYC 128 NTC 1
fat_table -set MULTI_HOST_HISTO_STITCH_OVERLAP 8
histmem loadconf
wait 120

title Vn bcg 968x512 1.54 115
drive mom 43.9
histmem mode time
histmem preset 850
newfile HISTOGRAM_XYT
for {set i 0} {$i <10} {incr i} {
histmem pause
drive stth [expr $i*0.5+20]
histmem start block
}
save 
histmem stop

title Vn bcg 968x512 1.21 335
drive mom 68.4
histmem mode time
histmem preset 640
newfile HISTOGRAM_XYT
for {set i 0} {$i <10} {incr i} {
histmem pause
drive stth [expr $i*0.5+20]
histmem start block
}
save 
histmem stop

title Vn bcg 968x512 2.41 113
drive mom 53.4
histmem mode time
histmem preset 1280
newfile HISTOGRAM_XYT
for {set i 0} {$i <10} {incr i} {
histmem pause
drive stth [expr $i*0.5+20]
histmem start block
}
save 
histmem stop

hmm configure fat_multiple_datasets enable
histmem loadconf
wait 30

title Vn bcg 968x512 2.41 113 scan intensity
histmem mode time
histmem preset 120
newfile HISTOGRAM_XYT
for {set i 0} {$i <4} {incr i} {
drive mom [expr $i*0.2+53.0]
histmem start block
save $i



