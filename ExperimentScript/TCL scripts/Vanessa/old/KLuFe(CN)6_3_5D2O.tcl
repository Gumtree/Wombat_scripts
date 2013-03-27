user "vep"
email "vep@ansto.gov.au"
phone "9401"
tc1 controlsensorA
tc2 controlsensorA
tc1 range 5
tc2 range 5
# proc to set up rad coll

proc ::histogram_memory::pre_count {} {
#        global oct_cycles
        oscmd start 1
}


proc collect {time} {
	set tim1 [clock seconds]
	set bool 0
	histmem mode unlimited
	newfile HISTOGRAM_XY	

	set i 0
	while {$bool==0} {
		histmem start block
		save $i
		incr i
		set tim2 [expr [clock seconds]-$tim1]
		broadcast $tim2
		if {$tim2>$time*60} {set bool 1}
	}
}	
	
	
set spd [expr 4.0/60.0]
broadcast $spd
oct softlowerlim -1.5
oct softupperlim 1.5
#set oct_cycles 10
oct speed $spd
oct accel $spd
oct maxretry 0
#drive oct 1.0


title "KLuFe(CN)6_3_5D2O    10K"
samplename "KLuFe(CN)6_3_5D2O    10K"
tc1 tolerance 3
tc2 tolerance 3
drive tc1 10 tc2 10
collect 20

title "KLuFe(CN)6_3_5D2O    20K"
samplename "KLuFe(CN)6_3_5D2O    20K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 20 tc2 20
wait 120
collect 20

title "KLuFe(CN)6_3_5D2O    40K"
samplename "KLuFe(CN)6_3_5D2O    40K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 40 tc2 40
wait 120
collect 20

title "KLuFe(CN)6_3_5D2O    60K"
samplename "KLuFe(CN)6_3_5D2O    60K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 60 tc2 60
wait 400
collect 20

title "KLuFe(CN)6_3_5D2O    80K"
samplename "KLuFe(CN)6_3_5D2O    80K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 80 tc2 80
wait 400
collect 20

title "KLuFe(CN)6_3_5D2O    100K"
samplename "KLuFe(CN)6_3_5D2O    100K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 100 tc2 100
wait 400
collect 20

title "KLuFe(CN)6_3_5D2O    120K"
samplename "KLuFe(CN)6_3_5D2O    120K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 120 tc2 120
wait 900
collect 20

title "KLuFe(CN)6_3_5D2O    140K"
samplename "KLuFe(CN)6_3_5D2O    140K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 140 tc2 140
wait 900
collect 20

title "KLuFe(CN)6_3_5D2O    160K"
samplename "KLuFe(CN)6_3_5D2O    160K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 160 tc2 160
wait 900
collect 20

title "KLuFe(CN)6_3_5D2O    180K"
samplename "KLuFe(CN)6_3_5D2O    180K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 180 tc2 180
wait 900
collect 20

title "KLuFe(CN)6_3_5D2O    200K"
samplename "KLuFe(CN)6_3_5D2O    200K"
tc1 tolerance 3
tc2 tolerance 3
drive tc1 200 tc2 200
wait 1000
collect 20

title "KLuFe(CN)6_3_5D2O    250K"
samplename "KLuFe(CN)6_3_5D2O    250K"
tc1 tolerance 3
tc2 tolerance 3
drive tc1 250 tc2 250
wait 1000
collect 20

title "KLuFe(CN)6_3_5D2O    300K"
samplename "KLuFe(CN)6_3_5D2O    300K"
tc1 tolerance 3
tc2 tolerance 3
drive tc1 300 tc2 300
wait 1500
collect 20

title "KLuFe(CN)6_3_5D2O    350K"
samplename "KLuFe(CN)6_3_5D2O    350K"
tc1 tolerance 4
tc2 tolerance 4
drive tc1 350 tc2 350
wait 1500
collect 20

title "KLuFe(CN)6_3_5D2O    400K"
samplename "KLuFe(CN)6_3_5D2O    400"
tc1 tolerance 4
tc2 tolerance 4
drive tc1 400 tc2 400
wait 1500
collect 20

title "KLuFe(CN)6_3_5D2O    420K"
samplename "KLuFe(CN)6_3_5D2O    420"
tc1 tolerance 4
tc2 tolerance 4
drive tc1 420 tc2 420
wait 1500
collect 20

drive tc1 300 tc2 300

# uncomment this to kill rad coll
proc ::histogram_memory::pre_count {} {}
