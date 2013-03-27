title "PZN-PT 4.5% in CF3 300K"
sampletitle "PZN-PT"
samplename "PZN-PT single crystal"
user RW/ DG/ AJS
email ajs@ansto.gov.au

SetRadColl 55 2

#300K

sampledescription 300K 
RadCollScan som -40 0.2 601 2

tc1_asyncq send RAMP 1,1,10
wait 3
tc1 tolerance 5
tc1 settle 300
drive tc1 500

title "PZN-PT 4.5% in CF3 500K"
sampledescription 500K 
RadCollScan som -40 0.2 601 2

drive tc1 300
tc1_asyncq send RELAY 2,2,1

title "PZN-PT 4.5% in CF3 300K after de-pole"
sampledescription 300K 
RadCollScan som -40 0.2 701 2
