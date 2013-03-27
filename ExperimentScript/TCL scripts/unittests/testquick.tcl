run oct [expr -1]
		set j 0
		while {$j<1000} {
			wait 1
			if {[expr abs([SplitReply [oct]] +1)]< 0.05} {
				break
			}
			incr j
		}