title ErNiAl4 ramp 3-15K 
sampletitle mtth=90 112 2.41A
samplename ErNiAl4
user ajs for hutchison 
email ajs@ansto.gov.au

SetRadColl 60 2
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

drive tc1 15
RadCollTimed 

tc1_asyncq send RAMP 1,0,0.1
drive tc1 0

#tc1_asyncq send RELAY 2,2,1