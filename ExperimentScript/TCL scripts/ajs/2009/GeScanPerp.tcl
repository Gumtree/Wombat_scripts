title Ge stack in perpendicular plane


samplename mtth= 90 115 1.54A
user ajs
email ajs@ansto.gov.au

# 2nd layer (5 points)

sphi send PR`=-50000
sphi send BG`
sampletitle x=20 y=0
SimpleScan som -1 0.1 20 5

sphi send PR`=50000
sphi send BG`

sy send PR`=-50000
sy send BG`
sampletitle x=-0 y=20
SimpleScan som -1 0.1 20 5

sy send PR`=50000
sy send BG`
sampletitle x=0 y=0
SimpleScan som -1 0.1 20 5

sy send PR`=50000
sy send BG`
sampletitle x=0 y=-20
SimpleScan som -1 0.1 20 5

