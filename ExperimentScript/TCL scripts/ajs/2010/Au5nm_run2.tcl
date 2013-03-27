title Au 5nm magnet 10K 0T
sampletitle mtth=90 Ge115 1.54A
samplename nano Au
sampledescription nano Au
user Li / Taiwan
email ajs@ansto.gov.au for Taiwan group

tc1 lowerlimit 0
tc1 controlsensor sensorB
tc1 tolerance 40
tc1 settle 30

SetRadColl 60 2
RadCollRun 10 12

title Au 5nm magnet 10K 0.3T
magnet send s 0.3
wait 120
RadCollRun 10 12

title Au 5nm magnet 10K 3.0T
magnet send s 3.0
wait 300
RadCollRun 10 12

magnet send s 0.0
wait 300
tc1 settle 1800
drive tc1 25

title Au 5nm magnet 25K 0T
SetRadColl 60 2
RadCollRun 10 12

title Au 5nm magnet 25K 0.3T
magnet send s 0.3
wait 120
RadCollRun 10 12

title Au 5nm magnet 25K 3.0T
magnet send s 3.0
wait 300
RadCollRun 10 12

magnet send s 0.0
wait 300
tc1 settle 1800
drive tc1 55

title Au 5nm magnet 55K 0T
SetRadColl 60 2
RadCollRun 10 12

title Au 5nm magnet 55K 0.3T
magnet send s 0.3
wait 120
RadCollRun 10 12

title Au 5nm magnet 55K 3.0T
magnet send s 3.0
wait 300
RadCollRun 10 12


