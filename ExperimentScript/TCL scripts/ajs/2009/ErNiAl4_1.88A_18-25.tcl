title ErNiAl4 ramp 18-25K
sampletitle mtth=110 115 1.88A
samplename ErNiAl4
user ajs for hutchison 
email ajs@ansto.gov.au

tc1 lowerlimit 0
tc1 controlsensor sensorB
tc1_asyncq send RAMP 1,0,0.2
tc1_asyncq send SETP 1,18
tc1_asyncq send RAMP 1,1,0.2
tc1 tolerance 400
tc1 settle 0
tc1 range 5

drive tc1 25
SetRadColl 60 2
RadCollTimed 1 35

tc1_asyncq send RAMP 1,0,0.2
drive tc1 3

