# proc to set up rad coll


SetRadColl 60 2
drive echi 0
drive eom 0

title Cu1.8Se [001] scan

RadCollScan ephi -90 0.25 240 1
RadCollScan ephi -30 0.25 240 1
RadCollScan ephi 30 0.25 180 1

drive ephi -80.76
drive ephi -80.76

title Cu1.8Se [441] scan
drive echi 10.02
RadCollScan eom -32 0.25 317 1

title Cu1.8Se [221] scan
drive echi 19.47
RadCollScan eom -32 0.25 317 1

title Cu1.8Se [443] scan
drive echi 27.94
RadCollScan eom -32 0.25 317 1

title Cu1.8Se [111] scan
drive echi 35.26
RadCollScan eom -32 0.25 317 1

title Cu1.8Se [334] scan
drive echi 43.31
RadCollScan eom -32 0.25 317 1

title Cu1.8Se [112] scan
drive echi 54.74
RadCollScan eom -32 0.25 317 1

title Cu1.8Se [114] scan
drive echi 70.53
RadCollScan eom -32 0.25 317 1

title Cu1.8Se [119] scan
drive echi 81.07
RadCollScan eom -32 0.25 317 1

title Cu1.8Se [011] scan
drive echi 90
RadCollScan eom -32 0.25 317 1