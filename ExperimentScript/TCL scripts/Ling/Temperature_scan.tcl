user Chris Ling
title ""
samplename Ba3BiRu2O9
#title Ba3BiRu2O9 at base
#RadCollRun 15 1
#
for {set temperature 5} {$temperature < 160} {incr temperature 10} {
	title [concat Ba3BiRu2O9 at $temperature K]
	hset /sample/tc3/sensor/setpoint1 $temperature
	drive tc3_driveable2 $temperature
	wait 300
	RadCollRun 15 1
}

for {set temperature 160} {$temperature <= 180} {incr temperature 1} {
	title [concat Ba3BiRu2O9 at $temperature K]
	hset /sample/tc3/sensor/setpoint1 $temperature
	drive tc3_driveable2 $temperature
	wait 300
	RadCollRun 15 1
}

for {set temperature 180} {$temperature <= 160} {incr temperature -1} {
	title [concat Ba3BiRu2O9 at $temperature K]
	hset /sample/tc3/sensor/setpoint1 $temperature
	drive tc3_driveable2 $temperature
	wait 300
	RadCollRun 15 1
}

for {set temperature 180} {$temperature < 300} {incr temperature 10} {
	title [concat Ba3BiRu2O9 at $temperature K]
	hset /sample/tc3/sensor/setpoint1 $temperature
	drive tc3_driveable2 $temperature
	wait 300
	RadCollRun 15 1
}