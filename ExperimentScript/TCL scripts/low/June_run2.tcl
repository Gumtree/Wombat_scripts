
setradcoll 60 2

user Jim Low / Wei Pang / ajs/vkp
email ajs or vep@ansto.gov.au

title Ti2AlC recovery run 1 full protocol
sampledescription Ti2AlC solid cyl
samplename Ti2AlC
sampletitle Ti2AlC

ResetWest

sampletitle heat to 150 at 10deg/min
RadCollRampWest 150 600 1
sampletitle hold at 150 for 60min
RadCollTimed 1 60

# short hold points

sampletitle heat to 1325 at 10deg/min
RadCollRampWest 1325 600 1
sampletitle hold at 1325 for 300min
RadCollTimed 1 300

# cool down to rt

sampletitle cool to 500 at 10deg/min
RadCollRampWest 500 600 1

ResetWest

sampletitle cool to RT

RadCollTimed 1 100
RadCollTimed 1 100
RadCollTimed 1 100
RadCollTimed 1 100
RadCollTimed 1 100

