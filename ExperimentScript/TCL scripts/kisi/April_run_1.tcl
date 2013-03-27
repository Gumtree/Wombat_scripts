
setradcoll 60 2

user Kisi / Riley
email ajs or vep@ansto.gov.au

title Ti3C2 + Si  in vac furn 
sampledescription 
samplename 
sampletitle 

ResetWest

# short hold points

sampletitle heat to 150 at 10deg/min
RadCollRampWest 150 600 1
sampletitle hold at 150 for 30min
RadCollTimed 1 30

sampletitle heat to 1200 at 10deg/min
RadCollRampWest 1200 180 3
sampletitle hold at 1200 for 600min
RadCollTimed 1 60
RadCollTimed 1 60
RadCollTimed 1 60
RadCollTimed 1 60
RadCollTimed 1 60
RadCollTimed 1 60
RadCollTimed 1 60
RadCollTimed 1 60
RadCollTimed 1 60
RadCollTimed 1 60

sampletitle switch off (set to 0 deg) and cooldown
ResetWest

RadCollTimed 1 100
RadCollTimed 1 100
RadCollTimed 1 100
RadCollTimed 1 100
RadCollTimed 1 100

