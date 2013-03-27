title TbNiAl4 single xtal in magnet 0T field
sampletitle mtth=90 113 2.41A
samplename TbNiAl4 single xtal
user wayne hutchison / ajs
email ajs@ansto.gov.au

SetRadColl 30 2
som softupperlim 105 

tc1 lowerlimit 0
tc1 controlsensor sensorB
tc1_asyncq send RAMP 1,0,2.0

tc1 tolerance 40
tc1 settle 1800
tc1 range 5
drive tc1 0

#0 K

sampledescription 3K 0T
RadCollScan som -37 0.2 200 1
RadCollScan som 3 0.2 200 1
RadCollScan som 43 0.2 211 1

tc1_asyncq send RAMP 1,1,2.0
tc1 tolerance 2
tc1 settle 600
drive tc1 32.5

sampledescription 32.5K 0T
RadCollScan som -37 0.2 200 1
RadCollScan som 3 0.2 200 1
RadCollScan som 43 0.2 211 1

drive tc1 60

sampledescription 60K 0T
RadCollScan som -37 0.2 200 1
RadCollScan som 3 0.2 200 1
RadCollScan som 43 0.2 211 1


tc1_asyncq send RAMP 1,0,2.0
wait 3
tc1_asyncq send SETP 1,0
tc1 tolerance 10
drive tc1 0


