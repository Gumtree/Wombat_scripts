

sampletitle EuBaTiO3
sampledescription EuBaTiO3
samplename mtth 70 Ge 115 1.25A
user ajs / mona
email ajs@ansto.gov.au



title Eu0.5Ba0.5TiO3 in CF4 base temp 4K redo 
SetRadColl 60 2
RadCollRun 30 10


tc1_asyncq send RELAY 2,2,1

wait 3
tc1 tolerance 5
tc1 settle 3600
drive tc1 300


title Eu0.5Ba0.5TiO3 in CF4 base temp 300K redo
RadCollRun 30 10
