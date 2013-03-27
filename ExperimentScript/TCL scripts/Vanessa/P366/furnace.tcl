
setradcoll 60 2

user Lincoln /Sharma/vkp
email vep@ansto.gov.au

title 
sampledescription BiErPbO NWN4D2 0.8 0.11 0.09
samplename BiErPbO NWN4D2 0.8 0.11 0.09 
sampletitle BiErPbO NWN4D2 0.8 0.11 0.09

ResetWest

# short hold points
sampletitle heat to 400 at 10deg/min
RadCollRampWest 400 600 1
sampletitle hold at 400 for 5min
RadCollTimed 5 1
sampletitle hold at 400 for 20min
RadCollTimed 20 1

sampletitle heat to 450 at 10deg/min
RadCollRampWest 450 600 1
sampletitle hold at 450 for 5min
RadCollTimed 5 1
sampletitle hold at 450 for 20min
RadCollTimed 20 1

sampletitle heat to 500 at 10deg/min
RadCollRampWest 500 600 1
sampletitle hold at 500 for 5min
RadCollTimed 5 1
sampletitle hold at 500 for 20min
RadCollTimed 20 1

sampletitle heat to 550 at 10deg/min
RadCollRampWest 550 600 1
sampletitle hold at 550 for 5min
RadCollTimed 5 1
sampletitle hold at 550 for 20min
RadCollTimed 20 1

sampletitle heat to 600 at 10deg/min
RadCollRampWest 600 600 1
sampletitle hold at 600 for 5min
RadCollTimed 5 1
sampletitle hold at 600 for 20min
RadCollTimed 20 1

sampletitle heat to 650 at 10deg/min
RadCollRampWest 650 600 1
sampletitle hold at 650 for 5min
RadCollTimed 5 1
sampletitle hold at 650 for 20min
RadCollTimed 20 1

sampletitle heat to 700 at 10deg/min
RadCollRampWest 700 600 1
sampletitle hold at 700 for 5min
RadCollTimed 5 1
sampletitle hold at 700 for 20min
RadCollTimed 20 1

sampletitle heat to 750 at 10deg/min
RadCollRampWest 750 600 1
sampletitle hold at 750 for 5min
RadCollTimed 5 1
sampletitle hold at 750 for 20min
RadCollTimed 20 1

ResetWest

sampletitle cool to RT

RadCollTimed 1 100
RadCollTimed 1 100
RadCollTimed 1 100
RadCollTimed 1 100
RadCollTimed 1 100

