samplename Holmium BC at LT
user Andrew Princep	
title Proposal 1242
#
samplename [concat Holmium BC at base]
RadCollScan som 81 0.25 9 7
set tt 3.75;
while {$tt <= 6.5} {
	samplename [concat Holmium BC at $tt K]
	hset /sample/tc3/sensor/setpoint1 [expr $tt]
	hset /sample/tc3/sensor/setpoint2 [expr $tt]
	wait 600
	RadCollScan som 81 0.25 8 7
	set tt [expr $tt+0.25]
}