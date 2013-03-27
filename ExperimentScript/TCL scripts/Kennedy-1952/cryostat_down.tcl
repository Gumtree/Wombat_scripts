proc tempset {temp} {
	hset /sample/tc1/sensor/setpoint1 $temp
	set tempc [expr {$temp - 20}]
	if {$tempc < 4} {set tempc 4}
	if {$tempc > 310} {set tempc 310}
	hset /sample/tc2/sensor/setpoint1 $tempc
	drive tc1_driveable2 $temp
}

# note that this will substract step at each point
proc runtemps_down {start step fin} {
	set loopvar 1
	set i 0
	while {$loopvar} {
		set temp [ expr {$start - $i*$step}]
		if {$temp < $fin } {break}
		broadcast "Setting to $temp"
		tempset $temp
		wait 600
		samplename [concat CdV2O4 at $temp, 2.41A]
		broadcast "Temperature should now be $temp"
		radcollrun 15 1
		incr i
	}
}

proc runtemps_up {start step fin} {
	set loopvar 1
	set i 0
	while {$loopvar} {
		set temp [ expr {$start + $i*$step}]
		if {$temp > $fin } {break}
		broadcast "Setting to $temp"
		tempset $temp
		wait 300
		samplename [concat CdV2O4 at $temp, 1.37A]
		broadcast "Temperature should now be $temp"
		radcollrun 20 1
		incr i
	}
}

hset /sample/tc1/control/tolerance1 0.5
hset /sample/tc1/control/tolerance2 0.5
#runtemps_down 280 10 150
#runtemps_down 145 5 5
runtemps_up 5 5 115
runtemps_up 120 10 300