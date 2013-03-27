title FePt3 cooldown on 1/2 1/2 1/2

samplename FePt3 on MgO
user saerbeck-klose-studer
email ajs@ansto.gov.au

SetRadColl 60 2

tc1 lowerlimit 0
tc1 controlsensor sensorB
tc1_asyncq send RAMP 1,0,2.0
tc1_asyncq send SETP 1,0
tc1_asyncq send RAMP 1,1,2.0
tc1 tolerance 400
tc1 settle 0
tc1 range 5

RadCollRun 2 90

sampletitle FePt3(1/2 1/2 1/2) 2.41A/90deg search
RadCollScan som 34.5 0.2 26 6

sampletitle FePt3(1/2 1/2 0) 2.41A/90deg search
RadCollScan som 66.5 0.2 26 6


#100 K
tc1 tolerance 400
tc1 settle 0
drive tc1 100
wait 1800
tc1 tolerance 3
tc1 settle 5
drive tc1 100

title FePt3 (1/2 1/2 0) at 100K
RadCollScan som 66.5 0.2 26 6

#200 K
tc1 tolerance 400
tc1 settle 0
drive tc1 200
wait 1800
tc1 tolerance 3
tc1 settle 5
drive tc1 200
##20 K
#drive tc1 20
#wait 900

title FePt3 (1/2 1/2 0) at 200K
RadCollScan som 66.5 0.2 26 6


#tc1_asyncq send RAMP 1,0,0.2
#drive tc1 300
#tc1_asyncq send RELAY 2,2,1
