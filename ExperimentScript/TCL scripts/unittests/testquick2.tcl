histmem stop 
	hmm configure fat_multiple_datasets disable
	histmem loadconf
	histmem mode unlimited
	oct speed 0.2
	drive oct [expr -$range]
	oct maxretry 0
	set spd [expr $range/$time]
	set timlim [expr $time+10]
	oct speed $spd
	oct accel $spd
	set prec [SplitReply [oct precision]]
	puts stdout $prec
	newfile HISTOGRAM_XY scratch
	histmem start
	wait 10
	histmem stop
	hmm configure fat_multiple_datasets enable