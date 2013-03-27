user vkp
email vep@ansto.gov.au
SetRadColl 60 2

tc1 tolerance 5 
drive tc1 40
title "Carbon nanotubes 20-40nm 40K"
samplename "Carbon nanotubes 20-40nm 40K"
RadCollRun 60 1

drive tc1 70
title "Carbon nanotubes 20-40nm 70K"
samplename "Carbon nanotubes 20-40nm 70K"
RadCollRun 60 1

drive tc1 100
wait 300
title "Carbon nanotubes 20-40nm 100K"
samplename "Carbon nanotubes 20-40nm 100K"
RadCollRun 60 1

drive tc1 150
wait 300
title "Carbon nanotubes 20-40nm 150K"
samplename "Carbon nanotubes 20-40nm 150K"
RadCollRun 40 1

drive tc1 200
wait 600
title "Carbon nanotubes 20-40nm 200K"
samplename "Carbon nanotubes 20-40nm 200K"
RadCollRun 60 1

drive tc1 250
wait 600
title "Carbon nanotubes 20-40nm 250K"
samplename "Carbon nanotubes 20-40nm 250K"
RadCollRun 40 1

drive tc1 300
wait 600
title "Carbon nanotubes 20-40nm 300K"
samplename "Carbon nanotubes 20-40nm 300K"
RadCollRun 60 1

