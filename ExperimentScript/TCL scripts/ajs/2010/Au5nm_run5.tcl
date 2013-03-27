title Au 5nm magnet 3K 0T 8hr
sampletitle mtth=90 Ge115 1.54A
samplename nano Au
sampledescription nano Au
user Li / Taiwan
email ajs@ansto.gov.au for Taiwan group

tc1 lowerlimit 0
tc1 controlsensor sensorB
tc1 tolerance 40
tc1 settle 1800
tc1 range 1
drive tc1 0

SetRadColl 60 2
RadCollRun 10 48

title Au 5nm magnet 3K 0.75T 16hr
magnet send s 0.75
wait 120
RadCollRun 10 96


