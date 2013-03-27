ephi speed 2
ephi accel 1
ephi maxretry 0

drive eom 38

title "ODS steel remeasure"
sampledescription "2.41A 113 90 deg eom 38 for 76 deg 2theta"
samplename "ODS steel"
user "Ulf / Kun / ajs"
email "kuy@ansto.gov.au"

ephi softlowerlim -185
ephi softupperlim 185

drive echi 0
drive ephi -180
SimpleScan ephi -180 3 120 40

drive echi 15
drive ephi -180
SimpleScan ephi -180 3 120 40

drive echi 30
drive ephi -180
SimpleScan ephi -180 3 120 40

drive echi 45
drive ephi -180
SimpleScan ephi -180 3 120 40

drive echi 60
drive ephi -180
SimpleScan ephi -180 3 120 40


drive echi 75
drive ephi -180
SimpleScan ephi -180 3 120 40


drive echi 90
drive ephi -180
SimpleScan ephi -180 3 120 40


