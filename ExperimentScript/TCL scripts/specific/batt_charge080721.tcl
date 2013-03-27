
proc SimpleRun {steptime numsteps} {
	histmem mode time
	histmem preset $steptime
	newfile HISTOGRAM_XY
	for {set i 0} {$i < $numsteps} {incr i} {
		histmem start block
		save $i
	}
}

title NiO cell #2 manual charge 1mA


SimpleRun 300 24
SimpleRun 300 24
SimpleRun 300 24
SimpleRun 300 24
SimpleRun 300 24
SimpleRun 300 24
SimpleRun 300 24
SimpleRun 300 24
SimpleRun 300 24
SimpleRun 300 24