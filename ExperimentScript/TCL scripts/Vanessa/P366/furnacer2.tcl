
setradcoll 60 2

user Lincoln /Sharma/vkp
email vep@ansto.gov.au

title 
sampledescription BiErPbO FJLn6 0.70 0.08 0.22
samplename BiErPbO FJLn6 0.70 0.08 0.22 
sampletitle BiErPbO FJLn6 0.70 0.08 0.22

ResetWest

# short hold points
sampletitle heat to 400 at 10deg/min
RadCollRampWest 400 600 1
sampletitle hold at 400 for 15min
RadCollTimed 15 1

sampletitle heat to 500 at 10deg/min
RadCollRampWest 500 600 1
sampletitle hold at 500 for 15min
RadCollTimed 15 1

sampletitle heat to 600 at 10deg/min
RadCollRampWest 600 600 1
sampletitle hold at 600 for 15min
RadCollTimed 15 1

sampletitle heat to 650 at 10deg/min
RadCollRampWest 650 600 1
sampletitle hold at 650 for 15min
RadCollTimed 15 1

ResetWest

sampletitle cool to RT

RadCollTimed 1 100
RadCollTimed 1 100
RadCollTimed 1 100
RadCollTimed 1 100
RadCollTimed 1 100

