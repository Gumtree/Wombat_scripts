# proc to set up rad coll

proc ::histogram_memory::pre_count {} {
#        global oct_cycles
        oscmd start 1
}
proc CollAxisScan {motor start step numsteps} {

	histmem mode unlimited
	set spd [expr 4.0/60.0]
	broadcast $spd
	oct softlowerlim -1.5
	oct softupperlim 1.5
	oct speed $spd
	oct accel $spd
	oct maxretry 0
	drive oct 1.0

	newfile HISTOGRAM_XY
	for {set i 0} {$i <$numsteps} {incr i} {
		drive $motor [expr $i*$step+$start]
		histmem start block
		save $i
	}
}	

title BaFe1.74Co0.26As2 at base T 
sampledescription BaFe1.74Co0.26As2 T = 3.6K
samplename BaFe1.74Co0.26As2
user ajs
email ajs@ansto.gov.au

drive sphi -2.46
drive schi 91.72

CollAxisScan som  0 0.2 100
CollAxisScan som 20 0.2 100
CollAxisScan som 40 0.2 100
CollAxisScan som 60 0.2 100
CollAxisScan som 80 0.2 100

drive sphi 2.46
drive schi 88.28

CollAxisScan som  0 0.2 100
CollAxisScan som 20 0.2 100
CollAxisScan som 40 0.2 100
CollAxisScan som 60 0.2 100
CollAxisScan som 80 0.2 100

title BaFe1.74Co0.26As2 at T=20K 

drive tc1 20.0
CollAxisScan som  4.0 0.1 11
CollAxisScan som  22.0 0.1 11


title BaFe1.74Co0.26As2 at T=25K 
sampledescription BaFe1.74Co0.26As2 T = 25K
samplename BaFe1.74Co0.26As2
user ajs
email ajs@ansto.gov.au

drive tc1 25.0
drive sphi -2.46
drive schi 91.72

CollAxisScan som  0 0.2 100
CollAxisScan som 20 0.2 100
CollAxisScan som 40 0.2 100
CollAxisScan som 60 0.2 100
CollAxisScan som 80 0.2 100

drive sphi 2.46
drive schi 88.28

CollAxisScan som  0 0.2 100
CollAxisScan som 20 0.2 100
CollAxisScan som 40 0.2 100
CollAxisScan som 60 0.2 100
CollAxisScan som 80 0.2 100

title BaFe1.74Co0.26As2 at T=30K 

drive tc1 30.0
CollAxisScan som  4.0 0.1 11
CollAxisScan som  22.0 0.1 11

title BaFe1.74Co0.26As2 at T=40K 

drive tc1 40.0
CollAxisScan som  4.0 0.1 11
CollAxisScan som  22.0 0.1 11

title BaFe1.74Co0.26As2 at T=60K 

drive tc1 60.0
CollAxisScan som  4.0 0.1 11
CollAxisScan som  22.0 0.1 11

title BaFe1.74Co0.26As2 at T=80K 

drive tc1 80.0
CollAxisScan som  4.0 0.1 11
CollAxisScan som  22.0 0.1 11

title BaFe1.74Co0.26As2 at T=100K 

drive tc1 100.0
CollAxisScan som  4.0 0.1 11
CollAxisScan som  22.0 0.1 11

title BaFe1.74Co0.26As2 at T=120K 

drive tc1 120.0
CollAxisScan som  4.0 0.1 11
CollAxisScan som  22.0 0.1 11


# uncomment this to kill rad coll
proc ::histogram_memory::pre_count {} {}
