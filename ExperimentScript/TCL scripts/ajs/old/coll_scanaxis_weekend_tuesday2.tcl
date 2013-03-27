# proc to set up rad coll

proc ::histogram_memory::pre_count {} {
#        global oct_cycles
#        oscmd start 1
}
proc CollAxisScan {motor start step numsteps} {

	histmem mode time
	histmem preset 15
	set spd [expr 4.0/60.0]
	broadcast $spd
	oct softlowerlim -1.5
	oct softupperlim 1.5
	oct speed $spd
	oct accel $spd
	oct maxretry 0
#	drive oct 1.0

	newfile HISTOGRAM_XY
	for {set i 0} {$i <$numsteps} {incr i} {
		drive $motor [expr $i*$step+$start]
		histmem start block
		save $i
	}
}	

#title BaFe1.74Co0.26As2 at T 25K tilt phi -2 chi +2
sampledescription BaFe1.74Co0.26As2 
samplename BaFe1.74Co0.26As2
user ajs
email ajs@ansto.gov.au



title BaFe1.74Co0.26As2 at T80K 

drive tc1 80.0
drive sphi 0
drive schi 90
CollAxisScan som  3.5 0.1 33
drive sphi 2.46
drive schi 88.28
CollAxisScan som  21.5 0.1 33 

title BaFe1.74Co0.26As2 at T100K 

drive tc1 100.0
drive sphi 0
drive schi 90
CollAxisScan som  3.5 0.1 33
drive sphi 2.46
drive schi 88.28
CollAxisScan som  21.5 0.1 33 

title BaFe1.74Co0.26As2 at T120K 

drive tc1 120.0
drive sphi 0
drive schi 90
CollAxisScan som  3.5 0.1 33
drive sphi 2.46
drive schi 88.28
CollAxisScan som  21.5 0.1 33 

title BaFe1.74Co0.26As2 at T140K 

drive tc1 140.0
drive sphi 0
drive schi 90
CollAxisScan som  3.5 0.1 33
drive sphi 2.46
drive schi 88.28
CollAxisScan som  21.5 0.1 33 
# uncomment this to kill rad coll
proc ::histogram_memory::pre_count {} {}
