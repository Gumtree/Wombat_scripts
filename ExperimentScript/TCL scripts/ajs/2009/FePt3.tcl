sampletitle FePt3(1/2 1/2 0) 2.41A/90deg
samplename FePt3 on MgO
user saerbeck-klose-studer
email ajs@ansto.gov.au

SetRadColl 60 2

tc1 lowerlimit 0
tc1 controlsensor sensorB
tc1_asyncq send RAMP 1,0,4.0
tc1_asyncq send SETP 1,0
tc1_asyncq send RAMP 1,1,4.0

tc1 range 5

#sampletitle FePt3(200) 2.41A/90deg
#radCollScan 72.5 0.2 21 2

#sampletitle FePt3(220) 2.41A/90deg
#radCollScan 50.5 0.2 21 3

 

title FePt3 (1/2 1/2 0) at ~10K
RadCollScan som 93.7 0.1 11 17

#100 K
tc1 tolerance 400
tc1 settle 0
drive tc1 100
wait 1800
tc1 tolerance 3
tc1 settle 5
drive tc1 100

title FePt3 (1/2 1/2 0) at 100K
RadCollScan som 93.7 0.1 11 17

#200 K
tc1 tolerance 400
tc1 settle 0
drive tc1 200
wait 1800
tc1 tolerance 3
tc1 settle 5
drive tc1 200

title FePt3 (1/2 1/2 0) at 200K
RadCollScan som 93.7 0.1 11 17

#300 K
tc1 tolerance 400
tc1 settle 0
drive tc1 300
wait 1800
tc1 tolerance 3
tc1 settle 5
drive tc1 300

title FePt3 (1/2 1/2 0) at 300K
RadCollScan som 93.7 0.1 11 17





#tc1_asyncq send RAMP 1,0,0.2
#drive tc1 300
#tc1_asyncq send RELAY 2,2,1
