

user Kun/Reid/Carr
email ajs or kuy@ansto.gov.au

title Zr2.5Nb run 2 
sampledescription Zr2.5Nb
samplename Zr2.5Nb
sampletitle Zr2.5Nb

SetRadColl 60 2

ResetWest

sampletitle heat to 500 at 20deg/min 1 min runs
RadCollRampWest 500 1200 1

sampletitle heat to 950 at 2deg/min 1 min runs
RadCollRampWest 950 120 1

sampletitle hold at 950 for 2 minutes
RadCollRun 1 2

sampletitle cool to 500 at 2deg/min
RadCollRampWest 500 120 1

# cool down to rt

ResetWest

sampletitle cool to RT

RadCollRun 1 100
RadCollRun 1 100


