title d-HMB in cryofurnace 10-450K rate 0.2 
sampletitle d-HMB
samplename dHMB mtth 90 1.54A
user vkp/ Sharon Rivera
email vep@ansto.gov.au
SetRadColl 60 2

tc1 controlsensor sensorA
tc2 controlsensor sensorA
tc1 range 5
tc2 range 5

tc1_asyncq send RAMP 1,0,0.2
wait 3
tc2_asyncq send RAMP 1,0,0.2
wait 3
tc1_asyncq send SETP 1,9
wait 3
tc1_asyncq send RAMP 1,1,0.2
wait 3
tc2_asyncq send SETP 1,9
wait 3
tc2_asyncq send RAMP 1,1,0.2
wait 3

tc1 tolerance 400
tc2 tolerance 400
tc1 settle 0
tc2 settle 0
wait 3

#30K
sampletitle ramp to 30
drive tc1 30 tc2 30
RadCollTimed 1 105