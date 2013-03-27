
setradcoll 60 2

title 17-4 PH heat to 1310
sampledescription debinded steel
samplename 17-4 PH
user neutron school / powder team
email ajs or vep@ansto.gov.au


ResetWest

sampletitle heat to 1260 at 10deg/min
RadCollRampWest 1260 600 1

sampletitle heat to 1310 at 3deg/min
RadCollRampWest 1310 180 1
sampletitle hold 1hr
RadCollTimed 1 60
sampletitle cool to 1000
RadCollRampWest 1000 600 1
sampletitle cool to room temp
ResetWest
RadCollTimed 1 100
RadCollTimed 1 100
RadCollTimed 1 100
RadCollTimed 1 100
RadCollTimed 1 100

# short hold points


