# proc to set up rad coll

proc ::histogram_memory::pre_count {} {
#        global oct_cycles
#       oscmd start 1
}
proc CollAxisScan {motor start step numsteps} {

	newfile HISTOGRAM_XY scratch
	for {set i 0} {$i <$numsteps} {incr i} {
		drive $motor [expr $i*$step+$start]
		histmem start block
		save $i
	}
}	

eom softlowerlimit -40
eom softupperlimit 45

histmem mode time
histmem preset 60

samplename test histogram server
sampletitle none- reactor down

title run histo server to try generate crashes
drive echi 0

CollAxisScan eom  -40 0.2 100
CollAxisScan eom  -20 0.2 100
CollAxisScan eom  -0 0.2 100
CollAxisScan eom  20 0.2 125

drive echi 13

CollAxisScan eom  -40 0.2 100
CollAxisScan eom  -20 0.2 100
CollAxisScan eom  -0 0.2 100
CollAxisScan eom  20 0.2 125

drive echi 28

CollAxisScan eom  -40 0.2 100
CollAxisScan eom  -20 0.2 100
CollAxisScan eom  -0 0.2 100
CollAxisScan eom  20 0.2 125

drive echi 43

CollAxisScan eom  -40 0.2 100
CollAxisScan eom  -20 0.2 100
CollAxisScan eom  -0 0.2 100
CollAxisScan eom  20 0.2 125

drive echi 58

CollAxisScan eom  -40 0.2 100
CollAxisScan eom  -20 0.2 100
CollAxisScan eom  -0 0.2 100
CollAxisScan eom  20 0.2 125

drive echi 73

CollAxisScan eom  -40 0.2 100
CollAxisScan eom  -20 0.2 100
CollAxisScan eom  -0 0.2 100
CollAxisScan eom  20 0.2 125

drive echi 88

CollAxisScan eom  -40 0.2 100
CollAxisScan eom  -20 0.2 100
CollAxisScan eom  -0 0.2 100
CollAxisScan eom  20 0.2 125


# uncomment this to kill rad coll
#proc ::histogram_memory::pre_count {} {}
