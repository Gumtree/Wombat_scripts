title TbNiAl4 single xtal in magnet 0T field
sampletitle mtth=90 113 2.41A
samplename TbNiAl4 single xtal
user ajs for hutchison 
email ajs@ansto.gov.au

SetRadColl 30 2

som softupperlim 105 

tc1 lowerlimit 0
tc1 controlsensor sensorB
tc1_asyncq send RAMP 1,1,0.4

tc1 tolerance 400
tc1 settle 0
tc1 range 5

#0 K
RadCollScan som -35 0.25 541 1

#20K
drive tc1 20
wait 750
RadCollScan som -35 0.25 541 1

#25K
drive tc1 25
wait 750
RadCollScan som -35 0.25 541 1

#27.5K
drive tc1 27.5
wait 375
RadCollScan som -35 0.25 541 1

#30K
drive tc1 30
wait 375
RadCollScan som -35 0.25 541 1

#32.5K
drive tc1 32.5
wait 375
RadCollScan som -35 0.25 541 1

#35K
drive tc1 35
wait 375
RadCollScan som -35 0.25 541 1

#37.5K
drive tc1 37.5
wait 375
RadCollScan som -35 0.25 541 1

#40K
drive tc1 40
wait 375
RadCollScan som -35 0.25 541 1

#42.5
drive tc1 42.5
wait 375
RadCollScan som -35 0.25 541 1

#45K
drive tc1 45
wait 375
RadCollScan som -35 0.25 541 1

#50K
drive tc1 50
wait 750
RadCollScan som -35 0.25 541 1

#55K
drive tc1 55
wait 750
RadCollScan som -35 0.25 541 1

#60K
drive tc1 60
wait 750
RadCollScan som -35 0.25 541 1

#70K
drive tc1 70
wait 750
RadCollScan som -35 0.25 541 1

#drive back to zero
tc1_asyncq send RAMP 1,0,0.2
wait 3
tc1_asyncq send SETP 1,0
wait 3
wait 3
drive tc1 0


#RadCollScan tc1 3 0.2 300 1

#tc1_asyncq send RAMP 1,0,0.1



