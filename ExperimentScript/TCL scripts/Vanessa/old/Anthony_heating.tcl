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
	
	
set spd [expr 4.0/60.0]tc2

broadcast $spd
oct softlowerlim -1.5
oct softupperlim 1.5
#set oct_cycles 10
oct speed $spd
oct accel $spd
oct maxretry 0
#drive oct 1.0


title "NC4D12CuZn(CN)4     20K"
samplename "NC4D12CuZn(CN)4     20K"
tc2 range 5
collect 30

title "NC4D12CuZn(CN)4     30K"
samplename "NC4D12CuZn(CN)4     30K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 30 tc2 30
wait 60
collect 30

title "NC4D12CuZn(CN)4     40K"
samplename "NC4D12CuZn(CN)4     40K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 40 tc2 40
wait 60
collect 30

title "NC4D12CuZn(CN)4     50K"
samplename "NC4D12CuZn(CN)4     50K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 50 tc2 50
wait 60
collect 30

title "NC4D12CuZn(CN)4     60K"
samplename "NC4D12CuZn(CN)4     60K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 60 tc2 60
wait 120
collect 30

title "NC4D12CuZn(CN)4     70K"
samplename "NC4D12CuZn(CN)4     70K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 70 tc2 70
wait 120
collect 30

title "NC4D12CuZn(CN)4     80K"
samplename "NC4D12CuZn(CN)4     80K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 80 tc2 80
wait 180
collect 30

title "NC4D12CuZn(CN)4     90K"
samplename "NC4D12CuZn(CN)4     90K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 90 tc2 90
wait 180
collect 30

title "NC4D12CuZn(CN)4     100K"
samplename "NC4D12CuZn(CN)4     100K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 100 tc2 100
wait 300
collect 30

title "NC4D12CuZn(CN)4     110K"
samplename "NC4D12CuZn(CN)4     110K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 110 tc2 110
wait 600
collect 30

title "NC4D12CuZn(CN)4     120K"
samplename "NC4D12CuZn(CN)4     120K"
tc1 tolerance 2
tc2 tolerance 2
drive tc1 120 tc2 120
wait 600
collect 30

title "NC4D12CuZn(CN)4     130K"
samplename "NC4D12CuZn(CN)4     130K"
drive tc1 130 tc2 130
wait 600
collect 30

title "NC4D12CuZn(CN)4     140K"
samplename "NC4D12CuZn(CN)4     140K"
drive tc1 140 tc2 140
wait 900
collect 30

title "NC4D12CuZn(CN)4     150K"
samplename "NC4D12CuZn(CN)4     150K"
drive tc1 150 tc2 150
wait 900
collect 30

title "NC4D12CuZn(CN)4     160K"
samplename "NC4D12CuZn(CN)4     160K"
drive tc1 160 tc2 160
wait 900
collect 30

title "NC4D12CuZn(CN)4     170K"
samplename "NC4D12CuZn(CN)4     170K"
drive tc1 170 tc2 170
wait 900
collect 30

title "NC4D12CuZn(CN)4     180K"
samplename "NC4D12CuZn(CN)4     180K"
drive tc1 180 tc2 180
wait 900
collect 30

title "NC4D12CuZn(CN)4     190K"
samplename "NC4D12CuZn(CN)4     190K"
drive tc1 190 tc2 190
wait 900
collect 30

title "NC4D12CuZn(CN)4     200K"
samplename "NC4D12CuZn(CN)4     200K"
tc1 tolerance 3
tc2 tolerance 3
drive tc1 200 tc2 200
wait 900
collect 30

title "NC4D12CuZn(CN)4     210K"
samplename "NC4D12CuZn(CN)4     210K"
drive tc1 210 tc2 210
wait 1100
collect 30

title "NC4D12CuZn(CN)4     220K"
samplename "NC4D12CuZn(CN)4     220K"
drive tc1 220 tc2 220
wait 1100
collect 30

title "NC4D12CuZn(CN)4     230K"
samplename "NC4D12CuZn(CN)4     230K"
drive tc1 230 tc2 230
wait 1100
collect 30

title "NC4D12CuZn(CN)4     240K"
samplename "NC4D12CuZn(CN)4     240K"
drive tc1 240 tc2 240
wait 1100
collect 30

title "NC4D12CuZn(CN)4     250K"
samplename "NC4D12CuZn(CN)4     250K"
drive tc1 250 tc2 250
wait 1100
collect 30

title "NC4D12CuZn(CN)4     260K"
samplename "NC4D12CuZn(CN)4     260K"
drive tc1 260 tc2 260
wait 1100
collect 30

title "NC4D12CuZn(CN)4     270K"
samplename "NC4D12CuZn(CN)4     270K"
drive tc1 270 tc2 270
wait 1100
collect 30

title "NC4D12CuZn(CN)4     280K"
samplename "NC4D12CuZn(CN)4     280K"
drive tc1 280 tc2 280
wait 1100
collect 30

title "NC4D12CuZn(CN)4     290K"
samplename "NC4D12CuZn(CN)4     290K"
drive tc1 290 tc2 290
wait 1100
collect 30

title "NC4D12CuZn(CN)4     300K"
samplename "NC4D12CuZn(CN)4     300K"
drive tc1 300 tc2 300
wait 1200
collect 30

title "NC4D12CuZn(CN)4     310K"
samplename "NC4D12CuZn(CN)4     310K"
drive tc1 310 tc2 310
wait 1200
collect 30

title "NC4D12CuZn(CN)4     320K"
samplename "NC4D12CuZn(CN)4     320K"
drive tc1 320 tc2 320
wait 1200
collect 30

title "NC4D12CuZn(CN)4     330K"
samplename "NC4D12CuZn(CN)4     330K"
drive tc1 330 tc2 330
wait 1200
collect 30

title "NC4D12CuZn(CN)4     340K"
samplename "NC4D12CuZn(CN)4     340K"
drive tc1 340 tc2 340
wait 1200
collect 30

title "NC4D12CuZn(CN)4     350K"
samplename "NC4D12CuZn(CN)4     350K"
tc1 tolerance 4
tc2 tolerance 4
drive tc1 350 tc2 350
wait 1800
collect 30

title "NC4D12CuZn(CN)4     360K"
samplename "NC4D12CuZn(CN)4     360 K"
drive tc1 360 tc2 360
wait 1800
collect 30

title "NC4D12CuZn(CN)4     370K"
samplename "NC4D12CuZn(CN)4     370 K"
drive tc1 370 tc2 370
wait 1800
collect 30

title "NC4D12CuZn(CN)4     380K"
samplename "NC4D12CuZn(CN)4     380 K"
drive tc1 380 tc2 380
wait 1800
collect 30

title "NC4D12CuZn(CN)4     390K"
samplename "NC4D12CuZn(CN)4     390 K"
drive tc1 390 tc2 390
wait 1800
collect 30

title "NC4D12CuZn(CN)4     400K"
samplename "NC4D12CuZn(CN)4     400 K"
drive tc1 400 tc2 400
wait 1800
collect 30

title "NC4D12CuZn(CN)4     410K"
samplename "NC4D12CuZn(CN)4     410 K"
drive tc1 410 tc2 410
wait 1800
collect 30

title "NC4D12CuZn(CN)4     420K"
samplename "NC4D12CuZn(CN)4     420 K"
drive tc1 420 tc2 420
wait 1800
collect 30

title "NC4D12CuZn(CN)4     430K"
samplename "NC4D12CuZn(CN)4     430 K"
drive tc1 430 tc2 430
wait 1800
collect 30

title "NC4D12CuZn(CN)4     440K"
samplename "NC4D12CuZn(CN)4     440 K"
drive tc1 440 tc2 440
wait 1800
collect 30

drive tc1 300 tc2 300

# uncomment this to kill rad coll
proc ::histogram_memory::pre_count {} {}
