# Collect EFC data to 225 at 180 
drive tc1_driveable 180
wait 1500
RadCollScan som 40 0.25 177 3
drive tc1_driveable 225
wait 1500
RadCollScan som 40 0.25 177 3
hset /sample/tc1/sensor/setpoint1 295