user "vep"
email "vep@ansto.gov.au"
phone "9401"
tc1 controlsensor sensorA
tc2 controlsensor sensorA
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

title "Ca2MnRuO6 10K"
samplename "Ca2MnRuO6 10K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 10 tc2 10
collect 20

title "Ca2MnRuO6 15K"
samplename "Ca2MnRuO6 15K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 15 tc2 15
wait 60
collect 20

title "Ca2MnRuO6 20K"
samplename "Ca2MnRuO6 20K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 20 tc2 20
wait 120
collect 20

title "Ca2MnRuO6 25K"
samplename "Ca2MnRuO6 25K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 25 tc2 25
wait 120
collect 20

title "Ca2MnRuO6 30K"
samplename "Ca2MnRuO6 30K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 30 tc2 30
wait 120
collect 20

title "Ca2MnRuO6 40K"
samplename "Ca2MnRuO6 40K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 40 tc2 40
wait 120
collect 20

title "Ca2MnRuO6 50K"
samplename "Ca2MnRuO6 50K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 50 tc2 50
wait 200
collect 20

title "Ca2MnRuO6 60K"
samplename "Ca2MnRuO6 60K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 60 tc2 60
wait 300
collect 20

title "Ca2MnRuO6 70K"
samplename "Ca2MnRuO6 70K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 70 tc2 70
wait 300
collect 20

title "Ca2MnRuO6 80K"
samplename "Ca2MnRuO6 80K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 80 tc2 80
wait 300
collect 20

title "Ca2MnRuO6 90K"
samplename "Ca2MnRuO6 90K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 90 tc2 90
wait 300
collect 20

title "Ca2MnRuO6 100K"
samplename "Ca2MnRuO6 100K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 100 tc2 100
wait 300
collect 20

title "Ca2MnRuO6 110K"
samplename "Ca2MnRuO6 110K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 110 tc2 110
wait 600
collect 20

title "Ca2MnRuO6 120K"
samplename "Ca2MnRuO6 120K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 120 tc2 120
wait 600
collect 20

title "Ca2MnRuO6 130K"
samplename "Ca2MnRuO6 130K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 130 tc2 130
wait 600
collect 20

title "Ca2MnRuO6 140K"
samplename "Ca2MnRuO6 140K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 140 tc2 140
wait 600
collect 20

title "Ca2MnRuO6 150K"
samplename "Ca2MnRuO6 150K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 150 tc2 150
wait 600
collect 20

title "Ca2MnRuO6 160K"
samplename "Ca2MnRuO6 160K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 160 tc2 160
wait 700
collect 20

title "Ca2MnRuO6 170K"
samplename "Ca2MnRuO6 170K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 170 tc2 170
wait 700
collect 20

title "Ca2MnRuO6 180K"
samplename "Ca2MnRuO6 180K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 180 tc2 180
wait 700
collect 20

title "Ca2MnRuO6 190K"
samplename "Ca2MnRuO6 190K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 190 tc2 190
wait 800
collect 20

title "Ca2MnRuO6 200K"
samplename "Ca2MnRuO6 200K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 200 tc2 200
wait 800
collect 20

title "Ca2MnRuO6 210K"
samplename "Ca2MnRuO6 210K"
tc1 tolerance 3
tc2 tolerance 3
drive tc1 210 tc2 210
wait 900
collect 20

title "Ca2MnRuO6 220K"
samplename "Ca2MnRuO6 220K"
tc1 tolerance 3
tc2 tolerance 3
drive tc1 220 tc2 220
wait 900
collect 20

title "Ca2MnRuO6 230K"
samplename "Ca2MnRuO6 230K"
tc1 tolerance 3
tc2 tolerance 3
drive tc1 230 tc2 230
wait 800
collect 20

title "Ca2MnRuO6 235K"
samplename "Ca2MnRuO6 235K"
tc1 tolerance 3
tc2 tolerance 3
drive tc1 235 tc2 235
wait 700
collect 20

title "Ca2MnRuO6 240K"
samplename "Ca2MnRuO6 240K"
tc1 tolerance 3
tc2 tolerance 3
drive tc1 240 tc2 240
wait 700
collect 20

title "Ca2MnRuO6 245K"
samplename "Ca2MnRuO6 245K"
tc1 tolerance 3
tc2 tolerance 3
drive tc1 245 tc2 245
wait 700
collect 20

title "Ca2MnRuO6 250K"
samplename "Ca2MnRuO6 250K"
tc1 tolerance 3
tc2 tolerance 3
drive tc1 250 tc2 250
wait 900
collect 20

title "Ca2MnRuO6 260K"
samplename "Ca2MnRuO6 260K"
tc1 tolerance 3
tc2 tolerance 3
drive tc1 260 tc2 260
wait 900
collect 20

title "Ca2MnRuO6 270K"
samplename "Ca2MnRuO6 270K"
tc1 tolerance 3
tc2 tolerance 3
drive tc1 270 tc2 270
wait 900
collect 20

title "Ca2MnRuO6 280K"
samplename "Ca2MnRuO6 280K"
tc1 tolerance 3
tc2 tolerance 3
drive tc1 280 tc2 280
wait 900
collect 20

title "Ca2MnRuO6 290K"
samplename "Ca2MnRuO6 290K"
tc1 tolerance 3
tc2 tolerance 3
drive tc1 290 tc2 290
wait 900
collect 20

title "Ca2MnRuO6 300K"
samplename "Ca2MnRuO6 300K"
tc1 tolerance 4
tc2 tolerance 4
drive tc1 300 tc2 300
wait 900
collect 20

# uncomment this to kill rad coll
proc ::histogram_memory::pre_count {} {}
