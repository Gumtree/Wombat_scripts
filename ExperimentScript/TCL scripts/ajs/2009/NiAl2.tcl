title NiAl single xtal in CF1
sampletitle mtth=90 335 1.22A
samplename NiAl single xtal
user Finlayson / Shapiro / ajs
email ajs@ansto.gov.au

SetRadColl 30 2

som softupperlim 105 

tc1 lowerlimit 0
tc1 controlsensor sensorA
tc2 lowerlimit 0
tc2 controlsensor sensorA



tc1 range 5
tc2 range 5


tc1_asyncq send RAMP 1,1,2
tc2_asyncq send RAMP 1,1,2
tc1 tolerance 2
tc2 tolerance 2
tc1 settle 300
tc2 settle 300




#110K
sampledescription 110K
RadCollScan som 74 0.2 71 1

#120K
drive tc1 120 tc2 120
sampledescription 120K
RadCollScan som -20 0.2 541 1

#130K
drive tc1 130 tc2 130
sampledescription 130K
RadCollScan som -20 0.2 541 1

#140K
drive tc1 140 tc2 140
sampledescription 120K
RadCollScan som -20 0.2 541 1

#150K
drive tc1 150 tc2 150
sampledescription 150K
RadCollScan som -20 0.2 541 1

#160K
drive tc1 160 tc2 160
sampledescription 160K
RadCollScan som -20 0.2 541 1

#180K
drive tc1 180 tc2 180
sampledescription 120K
RadCollScan som -20 0.2 541 1

#200K
drive tc1 200 tc2 200
sampledescription 200K
RadCollScan som -20 0.2 541 1

#300K
drive tc1 300 tc2 300
sampledescription 300K
RadCollScan som -20 0.2 541 1

