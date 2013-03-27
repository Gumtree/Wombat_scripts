# proc to set up rad coll

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

histmem mode time
histmem preset 30
title BaFe1.74Co0.26As2 at T 3K scan 0kl
sampletitle BaFe1.74Co0.26As2 single xtal
samplename BaFe1.74Co0.26As2
user ajs
email ajs@ansto.gov.au

histmem preset 30
#tc1 settle 30
#drive tc1 3

#CollAxisScan som -60 0.2 100
#CollAxisScan som -40 0.2 100
#CollAxisScan som -20 0.2 100
#CollAxisScan som 00 0.2 100
#CollAxisScan som 20 0.2 100
#CollAxisScan som 40 0.2 100

#title BaFe1.74Co0.26As2 at T 25K scan 0kl
#histmem preset 30
#tc1 settle 300
#drive tc1 25

#CollAxisScan som  -60 0.2 100
#CollAxisScan som  -40 0.2 100
#CollAxisScan som  -20 0.2 100
#CollAxisScan som  00 0.2 100
#CollAxisScan som  20 0.2 100
#CollAxisScan som  40 0.2 100

histmem preset 10

#title BaFe1.74Co0.26As2 at T3K

#drive tc1 3
#CollAxisScan som  -43 0.1 60
#CollAxisScan som  36 0.1 60

title BaFe1.74Co0.26As2 at T10K
tc1 settle 30
drive tc1 10
CollAxisScan som  -43 0.1 60
CollAxisScan som  36 0.1 60

#title BaFe1.74Co0.26As2 at T15K

#drive tc1 15
#CollAxisScan som  -43 0.1 60
#CollAxisScan som  36 0.1 60

tc1 settle 300
title BaFe1.74Co0.26As2 at T20K

drive tc1 20
CollAxisScan som  36 0.1 60
CollAxisScan som  -43 0.1 60


#title BaFe1.74Co0.26As2 at T25K

#drive tc1 25
#CollAxisScan som  -43 0.1 60
#CollAxisScan som  36 0.1 60

title BaFe1.74Co0.26As2 at T30K

drive tc1 30
CollAxisScan som  -43 0.1 60
CollAxisScan som  36 0.1 60

title BaFe1.74Co0.26As2 at T40K

drive tc1 40
CollAxisScan som  36 0.1 60
CollAxisScan som  -43 0.1 60


title BaFe1.74Co0.26As2 at T60K

drive tc1 60
CollAxisScan som  -43 0.1 60
CollAxisScan som  36 0.1 60
title BaFe1.74Co0.26As2 at T80K

drive tc1 80
CollAxisScan som  36 0.1 60
CollAxisScan som  -43 0.1 60

title BaFe1.74Co0.26As2 at T100K

drive tc1 100
CollAxisScan som  -43 0.1 60
CollAxisScan som  36 0.1 60
title BaFe1.74Co0.26As2 at T120K

drive tc1 120
CollAxisScan som  36 0.1 60
CollAxisScan som  -43 0.1 60


title BaFe1.74Co0.26As2 at T140K

drive tc1 140
CollAxisScan som  -43 0.1 60
CollAxisScan som  36 0.1 60

#title BaFe1.74Co0.26As2 at T200K

#drive tc1 200
#CollAxisScan som  -43 0.1 60
#CollAxisScan som  36 0.1 60
#title BaFe1.74Co0.26As2 at T300K

#drive tc1 300
#CollAxisScan som  -43 0.1 60
#CollAxisScan som  36 0.1 60



# uncomment this to kill rad coll
proc ::histogram_memory::pre_count {} {}
