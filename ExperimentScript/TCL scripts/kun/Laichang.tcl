

user Kun/ Lewis/kdl/ajs
email ajs or kuy@ansto.gov.au

title First run slow heat Ti_alloy
sampledescription Ti_alloy cyl in V can
samplename Ti_alloy
sampletitle Ti_alloy


SetRadColl 60 2

ResetWest

sampletitle heat to 150 at 10deg/min for element
RadCollRampWest 150 600 1
sampletitle hold at 150 for 30min
RadCollTimed 1 30

# short hold points

sampletitle heat to 500 at 10deg/min 1 min runs
RadCollRampWest 500 600 1

SetRadColl 10 2
sampletitle heat to 950 at 10deg/min
RadCollRampWest 950 600 1

sampletitle omega scan at 950C
RadCollScan -30 1 90 1

# cool down
SetRadColl 10 2
sampletitle cool to 500 at 10deg/min 10 sec/run
RadCollRampWest 500 600 1
# cool down to rt

ResetWest

sampletitle cool to RT
SetRadColl 60 2

RadCollTimed 1 100
RadCollTimed 1 100
RadCollTimed 1 100
RadCollTimed 1 100

