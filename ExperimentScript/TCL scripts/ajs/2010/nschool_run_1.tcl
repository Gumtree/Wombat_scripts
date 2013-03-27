
setradcoll 60 2

title 17-4 PH heat to 1390 Blaine no final hold
sampledescription debinded steel
samplename 17-4 PH
user neutron school / powder team
email ajs or vep@ansto.gov.au


ResetWest

sampletitle heat to 1000 at 10deg/min
RadCollRampWest 1000 600 1
sampletitle hold at 1000 for 30min
RadCollTimed 1 30
sampletitle heat to 1390 at 130deg/hr
RadCollRampWest 1390 130 1
sampletitle cool to 500
RadCollRampWest 500 600 1
sampletitle cool to room temp
ResetWest
RadCollTimed 1 100
RadCollTimed 1 100
RadCollTimed 1 100
RadCollTimed 1 100
RadCollTimed 1 100

# short hold points


