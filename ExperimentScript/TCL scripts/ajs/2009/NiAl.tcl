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


tc1 tolerance 40
tc2 tolerance 40
tc1 settle 1800
tc2 settle 1800
tc1 range 5
tc2 range 5





tc1_asyncq send RAMP 1,1,2
tc2_asyncq send RAMP 1,1,2
tc1 tolerance 2
tc2 tolerance 2
tc1 settle 300
tc2 settle 300



#80K
drive tc1 80 tc2 80
sampledescription 80K
RadCollScan som -20 0.2 541 1

#90K
drive tc1 90 tc2 90
sampledescription 90K
RadCollScan som -20 0.2 541 1

#100K
drive tc1 100 tc2 100
sampledescription 100K
RadCollScan som -20 0.2 541 1

#110K
drive tc1 110 tc2 110
sampledescription 110K
RadCollScan som -20 0.2 541 1

#120K
drive tc1 120 tc2 120
sampledescription 120K
RadCollScan som -20 0.2 541 1

