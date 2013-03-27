
setradcoll 60 2

user Kisi / Riley
email ajs or vep@ansto.gov.au

title TiC0.67 + Ge 
sampledescription Thermal Furnace Run 
samplename TiC0.67 + Ge
sampletitle TiC0.67 + Ge

ResetWest

sampletitle heat to 1250 at 3deg/min pt 1
RadCollRampWest 650 180 2
sampletitle heat to 1250 at 3deg/min pt 2
RadCollRampWest 1250 180 2

sampletitle hold at 1250 for 720min
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

