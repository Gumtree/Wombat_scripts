title Au 5nm magnet 10K 3.0T restart
sampletitle mtth=90 Ge115 1.54A
samplename nano Au
sampledescription nano Au
user Li / Taiwan
email ajs@ansto.gov.au for Taiwan group

tc1 lowerlimit 0
tc1 controlsensor sensorB

SetRadColl 60 2
RadCollRun 10 12

magnet send s 0.0
wait 300
tc1 settle 1800
tc1 range 1
drive tc1 0

title Au 5nm magnet 3K 0T
SetRadColl 60 2
RadCollRun 10 36

title Au 5nm magnet 3K 0.75T
magnet send s 0.75
wait 120
RadCollRun 10 36

title Au 5nm magnet 3K 3.0T
magnet send s 3.0
wait 300
RadCollRun 10 36

