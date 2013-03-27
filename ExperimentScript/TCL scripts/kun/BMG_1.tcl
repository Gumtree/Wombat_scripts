

user Kun/Reid/Carr
email ajs or kuy@ansto.gov.au

title BMG run 1 
sampledescription BMG1
samplename BMG1
sampletitle BMG1

SetRadColl 60 2

ResetWest

sampletitle heat to 220 at 10deg/min 1 min runs
RadCollRampWest 220 600 1

sampletitle hold at 220 for 2 minutes
RadCollRun 1 2

# cool down to rt

ResetWest

sampletitle cool to RT

RadCollRun 1 100
RadCollRun 1 100


