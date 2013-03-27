title Ge stack in perpendicular plane


samplename mtth= 90 115 1.54A
user ajs
email ajs@ansto.gov.au

# top layer (1 point)
sampletitle x=0 y=30
SimpleScan som 29 0.1 21 5

# 2nd layer (5 points)
sphi send PR`=37500
sphi send BG`
sy send PR`=-75000
sy send BG`
sampletitle x=-30 y=15
SimpleScan som 29 0.1 21 5

sy send PR`=37500
sy send BG`
sampletitle x=-15 y=15
SimpleScan som 29 0.1 21 5

sy send PR`=37500
sy send BG`
sampletitle x=0 y=15
SimpleScan som 29 0.1 21 5

sy send PR`=37500
sy send BG`
sampletitle x=15 y=15
SimpleScan som 29 0.1 21 5

sy send PR`=37500
sy send BG`
sampletitle x=30 y=15
SimpleScan som 29 0.1 21 5

# middle layer (5 points)
sphi send PR`=37500
sphi send BG`
sy send PR`=-150000
sy send BG`
sampletitle x=-30 y=0
SimpleScan som 29 0.1 21 5

sy send PR`=37500
sy send BG`
sampletitle x=-15 y=0
SimpleScan som 29 0.1 21 5

sy send PR`=37500
sy send BG`
sampletitle x=0 y=0
SimpleScan som 29 0.1 21 5

sy send PR`=37500
sy send BG`
sampletitle x=15 y=0
SimpleScan som 29 0.1 21 5

sy send PR`=37500
sy send BG`
sampletitle x=30 y=0
SimpleScan som 29 0.1 21 5

# lower layer (5 points)
sphi send PR`=37500
sphi send BG`
sy send PR`=-150000
sy send BG`
sampletitle x=-30 y=-15
SimpleScan som 29 0.1 21 5

sy send PR`=37500
sy send BG`
sampletitle x=-15 y=-15
SimpleScan som 29 0.1 21 5

sy send PR`=37500
sy send BG`
sampletitle x=0 y=-15
SimpleScan som 29 0.1 21 5

sy send PR`=37500
sy send BG`
sampletitle x=15 y=-15
SimpleScan som 29 0.1 21 5

sy send PR`=37500
sy send BG`
sampletitle x=30 y=-15
SimpleScan som 29 0.1 21 5
