# Collect data at multiple temperatures

set temperlist [list 2.25 2.75 5 10]

foreach temper $temperlist {
	hset /sample/tc1/sensor/setpoint1 $temper
	hset /sample/tc2/sensor/setpoint1 $temper
        drive tc1_driveable2 $temper
	wait 300
	samplename [concat FeTeSb at $temper K]
        radcollrun 30 7
}

set temperlist [list 15 20 25]

proc hightemps {
foreach temper $temperlist {
	hset /sample/tc1/sensor/setpoint1 $temper
	hset /sample/tc2/sensor/setpoint1 [expr $temper - 10]
	drive tc1_driveable2 $temper
	wait 300
	samplename [concat FeTeSb at $temper K]
	radcollrun 30 7
}
}

hightemps