

title "Proposal 367" 
sampledescription "mtth-120 Ge 113 2.955A"
samplename "Hexaferrite B=0.75T tempscan"
user Annemieke Mulders
email a.mulders@curtin.edu.au

#SetRadColl 60 2

sampletitle "Hexaferrite at 300"
tc1 tolerance 2
drive tc1 300
wait 600
RadCollScan som 1 0.25 60 1

sampletitle "Hexaferrite at 250"
tc1 tolerance 2
drive tc1 250
wait 600
RadCollScan som 1 0.25 60 1

sampletitle "Hexaferrite at 200"
tc1 tolerance 2
drive tc1 200
wait 600
RadCollScan som 1 0.25 60 1

sampletitle "Hexaferrite at 150"
tc1 tolerance 2
drive tc1 150
wait 600
RadCollScan som 1 0.25 60 1

sampletitle "Hexaferrite at 120"
tc1 tolerance 2
drive tc1 120
wait 600
RadCollScan som 1 0.25 60 1

sampletitle "Hexaferrite at 90"
tc1 tolerance 2
drive tc1 90
wait 600
RadCollScan som 1 0.25 60 1

sampletitle "Hexaferrite at 70"
tc1 tolerance 2
drive tc1 70
wait 600
RadCollScan som 1 0.25 60 1

sampletitle "Hexaferrite at 40"
tc1 tolerance 2
drive tc1 40
wait 600
RadCollScan som 1 0.25 60 1

sampletitle "Hexaferrite at 15"
tc1 tolerance 2
drive tc1 15
wait 600
RadCollScan som 1 0.25 60 1

