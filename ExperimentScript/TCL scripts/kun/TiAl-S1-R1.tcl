

user Kun/Reid/Carr
email ajs or kuy@ansto.gov.au

title TiAl-S1 run 1 
sampledescription TiAl-S1
samplename TiAl-S1
sampletitle TiAl-S1

SetRadColl 60 2

ResetWest

sampletitle heat to 1000 at 20deg/min 1 min runs
RadCollRampWest 1000 1200 1

sampletitle hold at 1000 for 2 minutes
RadCollRun 1 2

sampletitle heat to 1350 at 2deg/min 1 min runs
RadCollRampWest 1350 120 1

sampletitle hold at 1350 for 2 minutes
RadCollRun 1 2

sampletitle cool to 1000 at 2deg/min
RadCollRampWest 1000 120 1

sampletitle hold at 1000 for 2 minutes
RadCollRun 1 2

sampletitle cool to 500 at 20deg/min
RadCollRampWest 500 1200 1

# cool down to rt

ResetWest

sampletitle cool to RT

RadCollRun 1 100
RadCollRun 1 100


