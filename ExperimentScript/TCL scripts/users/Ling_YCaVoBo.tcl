

title "YCa3(VO)3(BO3)4 in cryostat" 
sampledescription "YCa3(VO)3(BO3)4"
samplename "mtth 90 Ge 113 2.41A"
user Chris Ling
email ajs@ansto.gov.au



SetRadColl 60 2
tc1 controlsensor sensorA
tc1 softlowerlim 0
tc1 range 5
tc1 tolerance 1
tc1 settle 300

tc1 lowerlimit 0


tc1_asyncq send RAMP 1,0,10
wait 3
tc1_asyncq send SETP 1,0
wait 3
tc1_asyncq send RAMP 1,1,10
wait 3


#base temp
sampletitle "hold 40 mins at 1.8K"
RadCollTimed 1 40

drive tc1 100

sampletitle "hold 40 mins at 100K"
RadCollTimed 1 40



