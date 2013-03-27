proc ::histogram_memory::pre_count {} {}


tc1 RampRate 800
tc1 Setpoint 100

#broadcast "blah"
#	set tclist [split [tc1 list] /n]
		broadcast [som list]
# broadcast [tc1 list]
#	set tclist [split $tcstr /r]
#		broadcast $tclist
#	set tc_wsp [lsearch $tclist "WorkingSetpoint"]
#		broadcast $tc_wsp
#	set tval [SplitReply $tc_wsp]
#		broadcast $tval


tc1 RampRate 10000
tc1 Setpoint 0
			