ephi speed 2
ephi accel 1
ephi maxretry 0

title "tex-Mg-MA40"
sampledescription "2.19A 113 80 deg 35 eom  for 56 deg 2theta"
samplename "MA40"
user "Hui Diao/Kun Yan/ /LRy/KDL/ ajs"
email "kuy@ansto.gov.au"

drive eom 20

ephi softlowerlim -185
ephi softupperlim 185

drive echi 45          
drive ephi -180
SimpleScan ephi -180 10 36 20

drive ephi -180
drive echi 0          
SimpleScan echi 0 5 16 20


drive echi 0
drive ephi -180