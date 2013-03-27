

title 
sampledescription Sn 7nm 
samplename mtth 90 Ge 113 2.41A
user WH Li 
email ajs@ansto.gov.au

tc1 controlsensor sensorD
tc1_asyncq send SETP 1,0
wait 3

SetRadColl 60 2


magnet send s 0.1
wait 600
title nano Sn in CF4+ magnet base temp ~3K 0.05T
RadCollRun 60 6

magnet send s 0.4
wait 120
title nano Sn in CF4+ magnet base temp ~3K 0.2T
RadCollRun 60 3

magnet send s 2
wait 240
title nano Sn in CF4+ magnet base temp ~3K 1.0T
RadCollRun 60 6

magnet send s 6
wait 480
title nano Sn in CF4+ magnet base temp ~3K 3.0T
RadCollRun 60 4

magnet send s 0

tc1 tolerance 5
tc1 settle 180
tc1 range 5
drive tc1 325

title nano Sn in CF4+ magnet base temp ~325K 0.T
RadCollRun 60 6

magnet send s 0.1
wait 60
title nano Sn in CF4+ magnet base temp ~325K 0.05T
RadCollRun 60 6

magnet send s 0.4
wait 120
title nano Sn in CF4+ magnet base temp ~325K 0.2T
RadCollRun 60 6

magnet send s 2
wait 240
title nano Sn in CF4+ magnet base temp ~325K 1.0T
RadCollRun 60 6

magnet send s 6
wait 480
title nano Sn in CF4+ magnet base temp ~325K 3.0T
RadCollRun 60 6