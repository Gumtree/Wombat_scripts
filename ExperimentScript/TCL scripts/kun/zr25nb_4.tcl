

user Kun/Reid/Carr
email ajs or kuy@ansto.gov.au

title Zr2.5Nb run 4 
sampledescription Zr2.5Nb
samplename Zr2.5Nb
sampletitle Zr2.5Nb

SetRadColl 60 2

ResetWest

sampletitle heat to 500 at 20deg/min 1 min runs
RadCollRampWest 500 1200 1

sampletitle heat to 1200 at 10deg/min 1 min runs
RadCollRampWest 1200 600 1

sampletitle hold at 1200 for 2 minutes
RadCollRun 1 2

sampletitle cool to 500 at 10deg/min
RadCollRampWest 500 600 1

# cool down to rt

ResetWest

sampletitle cool to RT

RadCollRun 1 100
RadCollRun 1 100


