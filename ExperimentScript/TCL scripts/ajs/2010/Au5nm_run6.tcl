title Au 5nm magnet 100K 0T
sampletitle mtth=90 Ge115 1.54A
samplename nano Au
sampledescription nano Au
user Li / Taiwan
email ajs@ansto.gov.au for Taiwan group

tc1 lowerlimit 0
tc1 controlsensor sensorB

SetRadColl 60 2
RadCollRun 10 19

title Au 5nm magnet 100K 0.1T
magnet send s 0.1
wait 120
RadCollRun 10 19

title Au 5nm magnet 100K 0.3T
magnet send s 0.3
wait 120
RadCollRun 10 19

title Au 5nm magnet 100K 0.75T
magnet send s 0.75
wait 240
RadCollRun 10 19

title Au 5nm magnet 100K 1.5T
magnet send s 1.5
wait 300
RadCollRun 10 19

title Au 5nm magnet 100K 3.0T
magnet send s 3.0
wait 300
RadCollRun 10 19

title Au 5nm magnet 300K 0T
magnet send s 0.0
wait 300
tc1 tolerance 5
tc1 settle 600
tc1 range 5
drive tc1 300
RadCollRun 10 19

title Au 5nm magnet 300K 0.1T
magnet send s 0.1
wait 120
RadCollRun 10 19

title Au 5nm magnet 300K 0.3T
magnet send s 0.3
wait 120
RadCollRun 10 19

title Au 5nm magnet 300K 0.75T
magnet send s 0.75
wait 240
RadCollRun 10 19

title Au 5nm magnet 300K 1.5T
magnet send s 1.5
wait 300
RadCollRun 10 19

title Au 5nm magnet 300K 3.0T
magnet send s 3.0
wait 300
RadCollRun 10 19