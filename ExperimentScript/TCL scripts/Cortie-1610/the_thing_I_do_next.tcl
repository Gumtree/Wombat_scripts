user David Cortie
title Proposal 1610
sampledescription mtth105-magnet-thinfilm-Ge311
samplename NiFe-Mn 0V LT detailed scan FC in 0T
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
# switch off compressor
hset /sample/tc1/other/relayCtrlParmLo 0

