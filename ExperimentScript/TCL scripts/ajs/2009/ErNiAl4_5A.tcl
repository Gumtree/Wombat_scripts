title ErNiAl4 ramp 3-15K at 5A 
sampletitle mtth=100 111 5.00A
samplename ErNiAl4
user ajs for hutchison 
email ajs@ansto.gov.au

SetRadColl 55 2

RadCollTimed 8 180
tc1 lowerlimit 0
tc1 controlsensor sensorB
tc1_asyncq send RAMP 1,0,0.1
wait 3
tc1_asyncq send SETP 1,3
wait 3
tc1_asyncq send RAMP 1,1,0.1
wait 3
tc1 tolerance 400
tc1 settle 0
tc1 range 5

RadCollScan tc1 3 0.2 61 8



tc1_asyncq send RAMP 1,0,0.1
drive tc1 0

