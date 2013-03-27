user David Cortie
title Proposal 1610
sampledescription mtth105-magnet-thinfilm-Ge311
samplename NiFe-Mn 0V RT detailed scan after 2T field
# The radial collimator collects for
# one minute per oscillation
setradcoll 60 2
#
# Collect data over a 60 degree range in
# two blocks
# 
radcollscan som 0 0.25 121 1
radcollscan som 30 0.25 121 1
#
# now field cool
magnet send s 2.0
# switch on compressor
hset /sample/tc1/other/relayCtrlParmLo 1
# wait two hours, collecting data
samplename NiFe-Mn 0V RT quick scan during cooling
radcollscan som 0 0.5 120 1
# switch off compressor
#hset /sample/tc1/other/relayCtrlParmLo 0
# switch off magnet
magnet send s 0
