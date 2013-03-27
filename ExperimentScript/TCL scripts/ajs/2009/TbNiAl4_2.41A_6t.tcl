title bcg with magnet for TbNiAl4
sampletitle mtth=90 113 2.41A
samplename none (sample removed)
user ajs for hutchison 
email ajs@ansto.gov.au

SetRadColl 30 2

som softupperlim 105 

#tc1 lowerlimit 0
#tc1 controlsensor sensorB
#tc1_asyncq send RAMP 1,1,0.5

#tc1 tolerance 400
#tc1 settle 0
#tc1 range 5

#0 K

RadCollScan som -35 0.5 271 1

