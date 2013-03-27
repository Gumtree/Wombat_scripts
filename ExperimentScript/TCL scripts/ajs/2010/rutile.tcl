

title rutile 1 gram for various takeoffs/ refls
sampledescription rutile
samplename mtth 95 Ge 113 2.51A
sampletitle rutile
user ajs
email ajs@ansto.gov.au

histmem mode unlimited
SetRadColl 60 2

set numsteps 7

proc dorun {} {
	newfile HISTOGRAM_XY
	for {set j 0} {$j < 15} {incr j} {
			drive mf2 [expr {$j*0.05}]	
			oscmd start 3
			hmm countblock
			save $j
	}
}

	for {set i 0} {$i < $numsteps} {incr i} {
		set mtthpos [expr {50+ $i*10}]
		drive mtth $mtthpos
		set offset [expr {1.5-($mtthpos-50)*0.2/65}]
		drive mom [expr {($mtthpos/2)-$offset}] 
		samplename mtth $mtthpos Ge 115
		dorun
		drive mom [expr {($mtthpos/2)-$offset+9.44}] 
		samplename mtth $mtthpos Ge 113
		dorun
	}

	