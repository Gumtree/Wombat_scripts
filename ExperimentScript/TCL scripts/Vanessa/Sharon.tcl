title d-HMB in cryofurnace 10-450K rate 0.2 
sampletitle d-HMB
samplename dHMB mtth 90 1.54A
user vkp/Sharon Rivera
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
tc1_asyncq send SETP 1,50
wait 3
tc1_asyncq send RAMP 1,1,0.2
wait 3
tc2_asyncq send SETP 1,50
wait 3
tc2_asyncq send RAMP 1,1,0.2
wait 3

tc1 tolerance 400
tc2 tolerance 400
tc1 settle 0
tc2 settle 0
wait 3

#70K
sampletitle ramp to 70
drive tc1 70 tc2 70
RadCollTimed 1 100
tc1 tolerance 0.5
tc2 tolerance 0.5
wait 10
tc1 tolerance 400
tc2 tolerance 400
wait 3

#90K
sampletitle ramp to 90
drive tc1 90 tc2 90
RadCollTimed 1 100
tc1 tolerance 0.5
tc2 tolerance 0.5
wait 10
tc1 tolerance 400
tc2 tolerance 400
wait 3

#110K
sampletitle ramp to 110
drive tc1 110 tc2 110
RadCollTimed 1 100
tc1 tolerance 0.5
tc2 tolerance 0.5
wait 10
tc1 tolerance 400
tc2 tolerance 400
wait 3

#130K
sampletitle ramp to 130
drive tc1 130 tc2 130
RadCollTimed 1 100
tc1 tolerance 1
tc2 tolerance 1
wait 10
tc1 tolerance 400
tc2 tolerance 400
wait 3

#150K
sampletitle ramp to 150
drive tc1 150 tc2 150
RadCollTimed 1 100
tc1 tolerance 1
tc2 tolerance 1
wait 10
sampletitle 150 K pattern
RadCollTimed 1 20

tc1 tolerance 400
tc2 tolerance 400
wait 3

#170K
sampletitle ramp to 170
drive tc1 170 tc2 170
RadCollTimed 1 100
tc1 tolerance 1
tc2 tolerance 1
wait 10
tc1 tolerance 400
tc2 tolerance 400
wait 3

#190K
sampletitle ramp to 190
drive tc1 190 tc2 190
RadCollTimed 1 100
tc1 tolerance 1
tc2 tolerance 1
wait 10
tc1 tolerance 400
tc2 tolerance 400
wait 3

#210K
sampletitle ramp to 210
drive tc1 210 tc2 210
RadCollTimed 1 100
tc1 tolerance 1
tc2 tolerance 1
wait 10
tc1 tolerance 400
tc2 tolerance 400
wait 3

#230K
sampletitle ramp to 230
drive tc1 230 tc2 230
RadCollTimed 1 100
tc1 tolerance 1
tc2 tolerance 1
wait 10
tc1 tolerance 400
tc2 tolerance 400
wait 3

#250K
sampletitle ramp to 250
drive tc1 250 tc2 250
RadCollTimed 1 100
tc1 tolerance 1
tc2 tolerance 1
wait 10
tc1 tolerance 400
tc2 tolerance 400
wait 3

#270K
sampletitle ramp to 270
drive tc1 270 tc2 270
RadCollTimed 1 100
tc1 tolerance 2
tc2 tolerance 2
wait 200
tc1 tolerance 400
tc2 tolerance 400
wait 3

#290K
sampletitle ramp to 290
drive tc1 290 tc2 290
RadCollTimed 1 100
tc1 tolerance 2
tc2 tolerance 2
wait 200
tc1 tolerance 400
tc2 tolerance 400
wait 3

#310K
sampletitle ramp to 310
drive tc1 310 tc2 310
RadCollTimed 1 100
tc1 tolerance 2
tc2 tolerance 2
wait 300
tc1 tolerance 400
tc2 tolerance 400
wait 3

#330K
sampletitle ramp to 330
drive tc1 330 tc2 330
RadCollTimed 1 100
tc1 tolerance 2
tc2 tolerance 2
wait 300
tc1 tolerance 400
tc2 tolerance 400
wait 3

#350K
sampletitle ramp to 350
drive tc1 350 tc2 350
RadCollTimed 1 100
tc1 tolerance 2
tc2 tolerance 2
wait 300
tc1 tolerance 400
tc2 tolerance 400
wait 3

#370K
sampletitle ramp to 370
drive tc1 370 tc2 370
RadCollTimed 1 100
tc1 tolerance 2
tc2 tolerance 2
wait 300
tc1 tolerance 400
tc2 tolerance 400
wait 3

#390K
sampletitle ramp to 390
drive tc1 390 tc2 390
RadCollTimed 1 100
tc1 tolerance 2
tc2 tolerance 2
wait 300
sampletitle 390 K pattern
RadCollTimed 1 20

tc1 tolerance 400
tc2 tolerance 400
wait 3

#410K
sampletitle ramp to 410
drive tc1 410 tc2 410
RadCollTimed 1 100
tc1 tolerance 3
tc2 tolerance 3
wait 900
tc1 tolerance 400
tc2 tolerance 400
wait 3

#430K
sampletitle ramp to 430
drive tc1 430 tc2 430
RadCollTimed 1 100
tc1 tolerance 3
tc2 tolerance 3
wait 900
tc1 tolerance 400
tc2 tolerance 400
wait 3

#450K
sampletitle ramp to 450
drive tc1 450 tc2 450
RadCollTimed 1 100

#turn ramp off
tc1_asyncq send RAMP 1,0,0.2
wait 3
tc2_asyncq send RAMP 1,0,0.2
wait 3
drive tc1 300 tc2 300
tc1_asyncq send RELAY 2,2,1
