title Au 5nm magnet 3K 0T
sampletitle mtth=90 Ge115 1.54A
samplename nano Au
sampledescription nano Au
user Li / Taiwan
email ajs@ansto.gov.au for Taiwan group

tc1 lowerlimit 0
tc1 controlsensor sensorB
tc1 tolerance 40
tc1 settle 2400
tc1 range 1
drive tc1 0

SetRadColl 60 2
RadCollRun 10 12

title Au 5nm magnet 3K 0.1T
magnet send s 0.1
wait 120
RadCollRun 10 12

title Au 5nm magnet 3K 0.3T
magnet send s 0.3
wait 120
RadCollRun 10 12

title Au 5nm magnet 3K 0.75T
magnet send s 0.75
wait 240
RadCollRun 10 12

title Au 5nm magnet 3K 1.5T
magnet send s 1.5
wait 300
RadCollRun 10 12

title Au 5nm magnet 3K 3.0T
magnet send s 3.0
wait 300
RadCollRun 10 12
