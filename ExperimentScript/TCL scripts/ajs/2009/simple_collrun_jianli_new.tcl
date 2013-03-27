

title test fridge behaviour for J Wang full test 
sampletitle none
samplename none (test run)
user ajs / jianli wang
email ajs@ansto.gov.au



# this seems to work
tc1 range 5
tc2 range 4
tc1 tolerance 400
tc2 tolerance 400
tc1 settle 0
tc2 settle 0

SetRadColl 55 2

#base temp
sampletitle hold 10 mins at 4K
RadCollTimed 1 10

#100K
sampletitle ramp 100
drive tc1 100 tc2 100
RadCollTimed 1 96

sampletitle hold 10 mins at 100K
RadCollTimed 1 10

#200K
sampletitle ramp 200
drive tc1 200 tc2 200
RadCollTimed 1 100

sampletitle hold 10 mins at 200K
RadCollTimed 1 10

#300K
sampletitle ramp 300
drive tc1 300 tc2 300
RadCollTimed 1 100

sampletitle hold 10 mins at 300K
RadCollTimed 1 10

#400K
sampletitle ramp 400
drive tc1 400 tc2 400
RadCollTimed 1 100

sampletitle hold 10 mins at 400K
RadCollTimed 1 10

#450K
sampletitle ramp 450
drive tc1 450 tc2 450
RadCollTimed 1 50

sampletitle hold 10 mins at 450K
RadCollTimed 1 10

sampletitle ramp 4K
drive tc1 4 tc2 4
RadCollTimed 1 446 

