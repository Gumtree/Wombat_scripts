# Collect data at multiple temperatures


proc hightemps {} {
	set temperlist [list 15 20 25]
        foreach temper $temperlist {
	hset /sample/tc1/sensor/setpoint1 $temper
	hset /sample/tc2/sensor/setpoint1 [expr $temper - 10]
	drive tc1_driveable2 $temper
	samplename [concat FeTeSb at $temper]
}
}

hightemps