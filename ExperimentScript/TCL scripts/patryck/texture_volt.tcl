# This will collect data at 30 degree intervals
# at each voltage setting
samplename STS_2
sampletitle STS_2 at different applied EF
#
# preliminary 90 degree steps to determine
# sample misalignment
samplename SBTN2.8 at 90 degree steps
radcollscan sphi 0 90 4 10

set voltlist [list 0 3000 6000]

foreach volts $voltlist {
	SetVolt [expr $volts]
	samplename [concat SBTN2.8 at $volts volts]
        radcollscan sphi 0 30 7 25
}
