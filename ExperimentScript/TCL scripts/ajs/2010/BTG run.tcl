

title BTG 10-300K
sampledescription BTG 10-300K
samplename mtth 114 Ge 113 2.86A
sampletitle BTG 10-300K
user Allen / Schmidt
email ajs@ansto.gov.au

SetRadColl 60 2

proc RunT {temp delay numsteps oscno} {
#	hset /sample/tc1/sensor/setpoint1 $temp
#	hset /sample/tc1/sensor/setpoint2 $temp

	drive tc1_driveable $temp tc1_driveable2 $temp 
	wait $delay
	newfile HISTOGRAM_XY
	for {set i 0} {$i < $numsteps} {incr i} {	
		oscmd start $oscno
		hmm countblock
		save $i
	}
}
	
	title BTG 300K
	RunT 301 10 1 15	
	title BTG 285K
	RunT 285 10 1 15
	title BTG 280K
	RunT 280 10 1 15
	title BTG 275K
	RunT 275 10 1 15	
	title BTG 270K
	RunT 270 10 1 15
	title BTG 265K
	RunT 265 10 1 15
	title BTG 250K
	RunT 250 10 1 15	
	title BTG 235K
	RunT 235 10 1 15
	title BTG 230K
	RunT 230 10 1 15
	title BTG 225K
	RunT 225 10 1 15	
	title BTG 220K
	RunT 220 10 1 15
	title BTG 215K
	RunT 215 10 1 15
	title BTG 4K
	RunT 4 10 1 15	
	title BTG 25K
	RunT 25 10 1 15
	title BTG 50K
	RunT 50 10 1 15
	title BTG 75K
	RunT 75 10 1 15	
	title BTG 100K
	RunT 100 10 1 15
	title BTG 125K
	RunT 125 10 1 15
	title BTG 150K
	RunT 150 10 1 15	
	title BTG 175K
	RunT 175 10 1 15
	title BTG 200K
	RunT 200 10 1 15
	title BTG 215K_up
	RunT 215 10 1 15	
	title BTG 220K_up
	RunT 220 10 1 15
	title BTG 225K_up
	RunT 225 10 1 15
	title BTG 230_up
	RunT 230 10 1 15	
	title BTG 235K_up
	RunT 235 10 1 15
	title BTG 250K_up
	RunT 250 10 1 15
	title BTG 265K_up
	RunT 265 10 1 15	
	title BTG 270K_up
	RunT 270 10 1 15
	title BTG 275K_up
	RunT 275 10 1 15
	title BTG 285K_up
	RunT 285 10 1 15	
	title BTG 300K_up
	RunT 300 10 1 15
	title BTG 325K_up
	RunT 325 10 1 15
	title BTG 350K_up
	RunT 350 10 1 15	
	title BTG 375K_up
	RunT 375 10 1 15
	title BTG 400K_up
	RunT 400 10 1 15	
	title BTG 425K_up
	RunT 425 10 1 15
	title BTG 450K_up
	RunT 450 10 1 15
	title BTG 475_up
	RunT 475 10 1 15	
	title BTG 500K_up
	RunT 500 10 1 15
	title BTG 525K_up
	RunT 525 10 1 15
	title BTG 550K_up
	RunT 550 10 1 15	
	title BTG 575K_up
	RunT 575 10 1 15
	title BTG 600K_up
	RunT 600 10 1 15
	title BTG 300K_final
	RunT 300 10 4 15				