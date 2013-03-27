
setradcoll 60 2

user Kisi / Riley
email ajs or vep@ansto.gov.au

title MAT00242 & 241 
sampledescription Thermal Furnace Run 
samplename MAT00242 & 241
sampletitle MAT00242 & 241

ResetWest

sampletitle heat to 1250 at 3deg/min
RadCollRampWest 1250 180 2

sampletitle hold at 1400 for 720min
RadCollTimed 2 180
RadCollTimed 2 180
RadCollTimed 2 180
RadCollTimed 2 180

sampletitle cool to 1000 at 10deg/min
RadCollRampWest 1000 600 2

sampletitle switch off (set to 0 deg) and cooldown
ResetWest

RadCollTimed 2 100
RadCollTimed 2 100
RadCollTimed 2 100
RadCollTimed 2 100
RadCollTimed 2 100

