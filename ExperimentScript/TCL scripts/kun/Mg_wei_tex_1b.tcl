ephi speed 2
ephi accel 1
ephi maxretry 0

title "tex-Mg-Wei Xu"
sampledescription "Wei Xu - Uni Melbourne - Mg - sample 1 PCM - 8pc + 8pbc 200->RT"
samplename "MG-1"
user "Wei Xu/Kun Yan/ /LRy/KDL/ ajs"
email "kuy@ansto.gov.au"

drive eom 20

ephi softlowerlim -185
ephi softupperlim 185

drive echi 0          
drive ephi -180
SimpleScan ephi -180 20 18 200


drive echi 0          
SimpleScan echi 0 10 10 90


drive echi 0
drive ephi -180