

title "Proposal 367" 
sampledescription "mtth-120 Ge 113 2.955A"
samplename "Hexaferrite 100K B scan"
user Annemieke Mulders
email a.mulders@curtin.edu.au

#SetRadColl 60 2
config rights manager ansto

sampletitle "Hexaferrite at 0 Tesla"
magnet send s 0.0
wait 30
RadCollScan som 1 0.25 60 1

sampletitle "Hexaferrite at 0.25 Tesla"
magnet send s 0.5
wait 100
RadCollScan som 1 0.25 60 1

sampletitle "Hexaferrite at 0.5 Tesla"
magnet send s 1.0
wait 100
RadCollScan som 1 0.25 60 1

sampletitle "Hexaferrite at 0.75 Tesla"
magnet send s 1.5
wait 100
RadCollScan som 1 0.25 60 1

sampletitle "Hexaferrite at 1.0 Tesla"
magnet send s 2.0
wait 100
RadCollScan som 1 0.25 60 1

sampletitle "Hexaferrite at 1.25 Tesla"
magnet send s 2.5
wait 100
RadCollScan som 1 0.25 60 1

sampletitle "Hexaferrite at 1.5 Tesla"
magnet send s 3.0
wait 100
RadCollScan som 1 0.25 60 1

sampletitle "Hexaferrite at 1.75 Tesla"
magnet send s 3.5
wait 100
RadCollScan som 1 0.25 60 1

sampletitle "Hexaferrite at 2.0 Tesla"
magnet send s 4.0
wait 100
RadCollScan som 1 0.25 60 1

sampletitle "Hexaferrite at 3.0 Tesla"
magnet send s 6.0
wait 300
RadCollScan som 1 0.25 60 1

