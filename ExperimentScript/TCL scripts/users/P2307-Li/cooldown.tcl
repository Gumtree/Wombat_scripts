# Multiple scans during cooling
#hset /sample/tc1/sensor/setpoint1 4.0
#hset /sample/tc2/sensor/setpoint1 4.0
# drive tc1_driveable2 4.0
#setradcoll 60 2
#samplename FeTeSb at base, 300 min
#sampletitle FeTeSb at base, 300 min
#radcollrun 30 10

#hset /sample/tc1/sensor/setpoint1 110.0
#hset /sample/tc2/sensor/setpoint1 100.0
#drive tc1_driveable2 110.0

#samplename FeTeSb 110 K, 240 min
#sampletitle FeTeSb 110 K, 240 min
#radcollrun 30 8

hset /sample/tc1/sensor/setpoint1 85
hset /sample/tc2/sensor/setpoint1 75
drive tc1_driveable2 85
wait 300
samplename FeTeSb 85 K, 240 min
sampletitle FeTeSb 85 K, 240 min
radcollrun 30 8

hset /sample/tc1/sensor/setpoint1 90
hset /sample/tc2/sensor/setpoint1 80
drive tc1_driveable2 90
wait 300
samplename FeTeSb 90 K, 240 min
sampletitle FeTeSb 90 K, 240 min
radcollrun 30 8

hset /sample/tc1/sensor/setpoint1 100
hset /sample/tc2/sensor/setpoint1 90
drive tc1_driveable2 100
wait 300
samplename FeTeSb 100 K, 240 min
sampletitle FeTeSb 100 K, 240 min
radcollrun 30 8

hset /sample/tc1/sensor/setpoint1 105
hset /sample/tc2/sensor/setpoint1 95
drive tc1_driveable2 105
wait 300
samplename FeTeSb 105 K, 240 min
sampletitle FeTeSb 105 K, 240 min
radcollrun 30 8

#set temperlist [list 2.25 2.75 5 10]

#foreach temper $temperlist {
#	hset /sample/tc1/sensor/setpoint1 $temper
#	hset /sample/tc2/sensor/setpoint1 $temper
#	drive tc1_driveable2 $temper
#	wait 300
#	samplename [concat FeTeSb at $temper K]
#	radcollrun 30 7
#}

proc hightemps {} {
	set temperlist [list 15 20 25]
	foreach temper $temperlist {
	hset /sample/tc1/sensor/setpoint1 $temper
	hset /sample/tc2/sensor/setpoint1 [expr $temper - 10]
	drive tc1_driveable2 $temper
	samplename [concat FeTeSb at $temper]
}
}

# hightemps