#Efficiency correction data
# 9/1/09 at 6pm until 6am 12/1/09 
user ajs/vep
email ajs@ansto.gov.au
SetRadColl 60 2

title V at 1.3A
sampletitle V at 1.3A
samplename V at 1.3A
run mtth 45
run mom 30.9 
RadCollScan stth 15 0.05 220 2

drive sy -19
title bcg for V at 1.3A
sampletitle none
samplename bcg for V at 1.3A
RadCollScan stth 15 0.05 220 1

drive sy 0
title V at 1.57A
sampletitle V at 1.57A
samplename V at 1.57A
run mtth 55
run mom 35.9 
RadCollScan stth 15 0.05 220 2

drive sy -19
title bcg for V at 1.57A
sampletitle none
samplename bcg for V at 1.57A
RadCollScan stth 15 0.05 220 1

drive sy 0
title V at 1.83A
sampletitle V at 1.83A
samplename V at 1.83A
run mtth 65
run mom 40.9 
RadCollScan stth 15 0.05 220 2

drive sy -19
title bcg for V at 1.83A
sampletitle none
samplename bcg for V at 1.83A
RadCollScan stth 15 0.05 220 1

drive sy 0
title V at 2.41A
sampletitle V at 2.41A
samplename V at 2.41A
run mtth 90
run mom 53.4 
RadCollScan stth 15 0.05 220 2

drive sy -19
title bcg for V at 2.41A
sampletitle none
samplename bcg for V at 2.41A
RadCollScan stth 15 0.05 220 1


