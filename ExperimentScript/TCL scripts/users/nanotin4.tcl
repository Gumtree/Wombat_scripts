

title 
sampledescription Sn 7nm 
samplename mtth 90 Ge 113 2.41A
user WH Li 
email ajs@ansto.gov.au

#tc1 controlsensor sensorD
#tc1_asyncq send SETP 1,0
#wait 3

#SetRadColl 60 2
drive oct 1
drive oct 1
drive oct 1

wait 30
title nano Sn 2.85K 3T 10 min run
SimpleRun 600 1

magnet send s 4
wait 240
title nano Sn 2.85K 2T 10 min run
SimpleRun 600 1

magnet send s 2
wait 240
title nano Sn 2.85K 1T 10 min run
SimpleRun 600 1

magnet send s 1
wait 120
title nano Sn 2.85K 0.5T 10 min run
SimpleRun 600 1

magnet send s 0.4
wait 120
title nano Sn 2.85K 0.2T 10 min run
SimpleRun 600 1

magnet send s 0.1
wait 120
title nano Sn 2.85K 0.05T 10 min run
SimpleRun 600 1

magnet send s 0
wait 120
title nano Sn 2.85K 0.0T 10 min run field off!
SimpleRun 600 1


