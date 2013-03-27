user "vep"
email "vep@ansto.gov.au"
phone "9401"
tc1 controlsensor sensorA
tc2 controlsensor sensorB
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

title "KLaFe(CN)6 cooling from 470K 1"
samplename "KLaFe(CN)6 cooling from 470K 1"
collect 10

title "KLaFe(CN)6 cooling from 470K 2"
samplename "KLaFe(CN)6 cooling from 470K 2"
collect 10

title "KLaFe(CN)6 cooling from 470K 3"
samplename "KLaFe(CN)6 cooling from 470K 3"
collect 10

title "KLaFe(CN)6 cooling from 470K 4"
samplename "KLaFe(CN)6 cooling from 470K 4"
collect 10

title "KLaFe(CN)6 cooling from 470K 5"
samplename "KLaFe(CN)6 cooling from 470K 5"
collect 10

title "KLaFe(CN)6 cooling from 470K 6"
samplename "KLaFe(CN)6 cooling from 470K 6"
collect 10

title "KLaFe(CN)6 cooling from 470K 7"
samplename "KLaFe(CN)6 cooling from 470K 7"
collect 10

title "KLaFe(CN)6 cooling from 470K 8"
samplename "KLaFe(CN)6 cooling from 470K 8"
collect 10

title "KLaFe(CN)6 cooling from 470K 9"
samplename "KLaFe(CN)6 cooling from 470K 9"
collect 10

title "KLaFe(CN)6 cooling from 470K 10"
samplename "KLaFe(CN)6 cooling from 470K 10"
collect 10

title "KLaFe(CN)6 cooling from 470K 11"
samplename "KLaFe(CN)6 cooling from 470K 11"
collect 10

title "KLaFe(CN)6 cooling from 470K 12"
samplename "KLaFe(CN)6 cooling from 470K 12"
collect 10

title "KLaFe(CN)6 cooling from 470K 13"
samplename "KLaFe(CN)6 cooling from 470K 13"
collect 10

title "KLaFe(CN)6 cooling from 470K 14"
samplename "KLaFe(CN)6 cooling from 470K 14"
collect 10

title "KLaFe(CN)6 cooling from 470K 15"
samplename "KLaFe(CN)6 cooling from 470K 15"
collect 10

title "KLaFe(CN)6 cooling from 470K 16"
samplename "KLaFe(CN)6 cooling from 470K 16"
collect 10

title "KLaFe(CN)6 cooling from 470K 17"
samplename "KLaFe(CN)6 cooling from 470K 17"
collect 10

title "KLaFe(CN)6 cooling from 470K 18"
samplename "KLaFe(CN)6 cooling from 470K 18"
collect 10

title "KLaFe(CN)6 cooling from 470K 19"
samplename "KLaFe(CN)6 cooling from 470K 19"
collect 10

title "KLaFe(CN)6 cooling from 470K 20"
samplename "KLaFe(CN)6 cooling from 470K 20"
collect 10

title "KLaFe(CN)6 cooling from 470K 21"
samplename "KLaFe(CN)6 cooling from 470K 21"
collect 10

title "KLaFe(CN)6 cooling from 470K 22"
samplename "KLaFe(CN)6 cooling from 470K 22"
collect 10

title "KLaFe(CN)6 cooling from 470K 23"
samplename "KLaFe(CN)6 cooling from 470K 23"
collect 10

title "KLaFe(CN)6 cooling from 470K 24"
samplename "KLaFe(CN)6 cooling from 470K 24"
collect 10

title "KLaFe(CN)6 cooling from 470K 25"
samplename "KLaFe(CN)6 cooling from 470K 25"
collect 10

title "KLaFe(CN)6 cooling from 470K 26"
samplename "KLaFe(CN)6 cooling from 470K 26"
collect 10

title "KLaFe(CN)6 cooling from 470K 27"
samplename "KLaFe(CN)6 cooling from 470K 27"
collect 10

title "KLaFe(CN)6 cooling from 470K 28"
samplename "KLaFe(CN)6 cooling from 470K 28"
collect 10

title "KLaFe(CN)6 cooling from 470K 29"
samplename "KLaFe(CN)6 cooling from 470K 29"
collect 10

title "KLaFe(CN)6 cooling from 470K 30"
samplename "KLaFe(CN)6 cooling from 470K 30"
collect 10

title "KLaFe(CN)6 cooling from 470K 31"
samplename "KLaFe(CN)6 cooling from 470K 31"
collect 10

title "KLaFe(CN)6 cooling from 470K 32"
samplename "KLaFe(CN)6 cooling from 470K 32"
collect 10

title "KLaFe(CN)6 cooling from 470K 33"
samplename "KLaFe(CN)6 cooling from 470K 33"
collect 10

title "KLaFe(CN)6 cooling from 470K 34"
samplename "KLaFe(CN)6 cooling from 470K 34"
collect 10

title "KLaFe(CN)6 cooling from 470K 35"
samplename "KLaFe(CN)6 cooling from 470K 35"
collect 10

title "KLaFe(CN)6 cooling from 470K 36"
samplename "KLaFe(CN)6 cooling from 470K 36"
collect 10

title "KLaFe(CN)6 cooling from 470K 37"
samplename "KLaFe(CN)6 cooling from 470K 37"
collect 10

title "KLaFe(CN)6 cooling from 470K 38"
samplename "KLaFe(CN)6 cooling from 470K 38"
collect 10

title "KLaFe(CN)6 cooling from 470K 39"
samplename "KLaFe(CN)6 cooling from 470K 39"
collect 10

title "KLaFe(CN)6 cooling from 470K 40"
samplename "KLaFe(CN)6 cooling from 470K 40"
collect 10

title "KLaFe(CN)6 cooling from 470K 41"
samplename "KLaFe(CN)6 cooling from 470K 41"
collect 10

title "KLaFe(CN)6 cooling from 470K 42"
samplename "KLaFe(CN)6 cooling from 470K 42"
collect 10

title "KLaFe(CN)6 cooling from 470K 43"
samplename "KLaFe(CN)6 cooling from 470K 43"
collect 10

title "KLaFe(CN)6 cooling from 470K 44"
samplename "KLaFe(CN)6 cooling from 470K 44"
collect 10

title "KLaFe(CN)6 cooling from 470K 45"
samplename "KLaFe(CN)6 cooling from 470K 45"
collect 10

title "KLaFe(CN)6 cooling from 470K 46"
samplename "KLaFe(CN)6 cooling from 470K 46"
collect 10

# uncomment this to kill rad coll
proc ::histogram_memory::pre_count {} {}
