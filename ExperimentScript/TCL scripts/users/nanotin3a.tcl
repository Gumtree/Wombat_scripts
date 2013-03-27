

title 
sampledescription Sn 7nm 
samplename mtth 90 Ge 113 2.41A
user WH Li 
email ajs@ansto.gov.au

#tc1 controlsensor sensorD
#tc1_asyncq send SETP 1,0
#wait 3

title nano Sn 300K 0.00T
SetRadColl 60 2
RadCollRun 20 4

magnet send s 0.4
wait 60
title nano Sn 300K 0.20T
SetRadColl 60 2
RadCollRun 20 4

magnet send s 6
wait 600
title nano Sn 300K 3.00 T
SetRadColl 60 2
RadCollRun 20 4

magnet send s 0
