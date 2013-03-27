

user Kun/Reid/Carr
email ajs or kuy@ansto.gov.au

title BMG run 2 
sampledescription BMG2
samplename BMG2
sampletitle BMG2

SetRadColl 60 2

ResetWest

sampletitle heat to 160 at 10deg/min 1 min runs
RadCollRampWest 160 600 1

sampletitle heat to 280 at 0.2deg/min 5 min runs
RadCollRampWest 280 12 5

sampletitle hold at 280 for 2 minutes
RadCollRun 1 2

# cool down to rt

ResetWest

sampletitle cool to RT

RadCollRun 1 100
RadCollRun 1 100


