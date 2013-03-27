user "jxh"
email "jxh@ansto.gov.au"
phone "9907"
SetRadColl 60 2

title "Tc 62 (TcCo) @2.95A in CF1"
tc1 tolerance 2
tc2 tolerance 2   

set mytemp 75
while {$mytemp <= 200} {
samplename "Tc 62 @ $mytemp K"
run tc1 [expr $mytemp] tc2 [expr $mytemp]
wait 300
RadCollRun 15 1
set mytemp [expr $mytemp + 5]
}

tc1_asyncq send RELAY 2,2,1