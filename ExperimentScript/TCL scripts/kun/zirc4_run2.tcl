

user Kun/ Lewis/kdl/ajs
email ajs or kuy@ansto.gov.au

title Second run fast heat zircalloy_4
sampledescription zircalloy_4 cyl in V can
samplename zircalloy_4
sampletitle zircalloy_4


SetRadColl 60 2

ResetWest

sampletitle heat to 150 at 10deg/min for element
RadCollRampWest 150 600 1
sampletitle hold at 150 for 30min
RadCollTimed 1 30

# short hold points

sampletitle heat to 700 at 30deg/min 1 min runs
RadCollRampWest 700 1800 1

SetRadColl 10 2
sampletitle heat to 1200 at 30deg/min
RadCollRampWest 1200 1800 1

sampletitle omega scan at 1200C
RadCollScan -30 1 90 1

# cool down
SetRadColl 10 2
sampletitle cool to 700 at 10deg/min 10 sec/run
RadCollRampWest 700 600 1
# cool down to rt

ResetWest

sampletitle cool to RT
SetRadColl 60 2

RadCollTimed 1 100
RadCollTimed 1 100
RadCollTimed 1 100
RadCollTimed 1 100

