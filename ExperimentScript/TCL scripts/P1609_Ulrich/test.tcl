foreach kk {1 2 3} {
	set q [eval magnet send ?]
	broadcast Magnet at [eval magnet send ?]
	wait 10
}