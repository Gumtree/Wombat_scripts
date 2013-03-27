title TbNiAl4 single xtal in magnet 4T field
sampletitle mtth=90 113 2.41A
samplename TbNiAl4 single xtal
user ajs for hutchison 
email ajs@ansto.gov.au

SetRadColl 30 2

som softupperlim 105 

tc1 lowerlimit 0
tc1 controlsensor sensorB

tc1_asyncq send RAMP 1,1,0.5

tc1 tolerance 400
tc1 settle 0
tc1 range 5

#0 K
#RadCollScan som 50 0.25 201 1

#10K
drive tc1 10
wait 840
RadCollScan som -15 0.25 341 1

#15K
drive tc1 15
wait 600
RadCollScan som -15 0.25 341 1

#20K
drive tc1 30
wait 600
RadCollScan som -15 0.25 341 1

#25K
drive tc1 25
wait 600
RadCollScan som -15 0.25 341 1

#32.5K
drive tc1 32.5
wait 900
RadCollScan som -15 0.25 341 1


#37.5K
#drive tc1 37.5
#wait 375
#RadCollScan som -15 0.25 341 1

#40K
#drive tc1 40
#wait 375
#RadCollScan som -15 0.25 341 1

#42.5
#drive tc1 42.5
#wait 375
#RadCollScan som -15 0.25 341 1

#50K
#drive tc1 50
#wait 750
#RadCollScan som -15 0.25 341 1

#55K
#drive tc1 55
#wait 750
#RadCollScan som -15 0.25 341 1

#60K
#drive tc1 60
#wait 3300
#RadCollScan som -35 0.25 541 1

#70K
#drive tc1 70
#wait 750
#RadCollScan som -15 0.25 341 1

#drive back to zero
tc1_asyncq send RAMP 1,0,0.5
wait 3
tc1_asyncq send SETP 1,0
wait 3
wait 3
drive tc1 305
wait 3
tc1_asyncq send RELAY 2,2,1




