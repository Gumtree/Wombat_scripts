# proc to set up rad coll DON'T USE

proc ::histogram_memory::pre_count {} {
#        global oct_cycles
#        oscmd start 1
}

proc CollAxisScan {motor start step numsteps} {


#	set spd [expr 4.0/60.0]
#	broadcast $spd
#	oct softlowerlim -1.5
#	oct softupperlim 1.5
#	oct speed $spd
#	oct maxretry 0
#	drive oct 1.0
#	broadcast $som

	newfile HISTOGRAM_XY
	for {set i 0} {$i <$numsteps} {incr i} {
		drive $motor [expr $i*$step+$start]
		histmem start block
		save $i
	}
}	

set aax 51.1
set aaz -61.3

histmem mode time
histmem preset 45
sampletitle BaFe1.74Co0.26As2 single xtal
samplename BaFe1.74Co0.26As2
user ajs
email ajs@ansto.gov.au




title BaFe1.74Co0.26As2 at T3K
tc1 settle 300
drive tc1 3

CollAxisScan som  $aaz 0.1 20
CollAxisScan som  $aax 0.1 20

title BaFe1.74Co0.26As2 at T10K
tc1 tolerance 1
tc1 settle 300
drive tc1 10
CollAxisScan som  $aax 0.1 20
CollAxisScan som  $aaz 0.1 20

title BaFe1.74Co0.26As2 at T15K

drive tc1 15
CollAxisScan som  $aaz 0.1 20
CollAxisScan som  $aax 0.1 20


title BaFe1.74Co0.26As2 at T17.5K
drive tc1 17.5
CollAxisScan som  $aax 0.1 20
CollAxisScan som  $aaz 0.1 20


title BaFe1.74Co0.26As2 at T20K

drive tc1 20
CollAxisScan som  $aaz 0.1 20
CollAxisScan som  $aax 0.1 20

title BaFe1.74Co0.26As2 at T22.5K

drive tc1 22.5
CollAxisScan som  $aax 0.1 20
CollAxisScan som  $aaz 0.1 20

title BaFe1.74Co0.26As2 at T25K

drive tc1 25
CollAxisScan som  $aaz 0.1 20
CollAxisScan som  $aax 0.1 20

title BaFe1.74Co0.26As2 at T27.5K

drive tc1 27.5
CollAxisScan som  $aax 0.1 20
CollAxisScan som  $aaz 0.1 20

title BaFe1.74Co0.26As2 at T30K

drive tc1 30
CollAxisScan som  $aaz 0.1 20
CollAxisScan som  $aax 0.1 20

title BaFe1.74Co0.26As2 at T35K

drive tc1 35
CollAxisScan som  $aax 0.1 20
CollAxisScan som  $aaz 0.1 20

title BaFe1.74Co0.26As2 at T40K
tc1 settle 600
drive tc1 40
CollAxisScan som  $aaz 0.1 20
CollAxisScan som  $aax 0.1 20

title BaFe1.74Co0.26As2 at T50K

drive tc1 50
CollAxisScan som  $aax 0.1 20
CollAxisScan som  $aaz 0.1 20

title BaFe1.74Co0.26As2 at T60K

drive tc1 60
CollAxisScan som  $aaz 0.1 20
CollAxisScan som  $aax 0.1 20

title BaFe1.74Co0.26As2 at T80K

drive tc1 80
CollAxisScan som  $aax 0.1 20
CollAxisScan som  $aaz 0.1 20

title BaFe1.74Co0.26As2 at T100K


drive tc1 100
CollAxisScan som  $aaz 0.1 20
CollAxisScan som  $aax 0.1 20

title BaFe1.74Co0.26As2 at T150K

drive tc1 150
CollAxisScan som  $aax 0.1 20
CollAxisScan som  $aaz 0.1 20

title BaFe1.74Co0.26As2 at T200K

drive tc1 200
CollAxisScan som  $aaz 0.1 20
CollAxisScan som  $aax 0.1 20

title BaFe1.74Co0.26As2 at T250K

drive tc1 250
CollAxisScan som  $aax 0.1 20
CollAxisScan som  $aaz 0.1 20


title BaFe1.74Co0.26As2 at T300K

drive tc1 300
CollAxisScan som  $aaz 0.1 20
CollAxisScan som  $aax 0.1 20





# uncomment this to kill rad coll
proc ::histogram_memory::pre_count {} {}
