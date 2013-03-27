title Ge stack in in parallel plane 115


samplename mtth= 90 115 1.54A REDO
user ajs
email ajs@ansto.gov.au

# 2nd layer (5 points)

sphi send PR`=25000
sphi send BG`
sy send PR`=-25000
sy send BG`
sampletitle x=-20 y=20
SimpleScan som -1 0.1 20 5

sy send PR`=25000
sy send BG`
sampletitle x=-10 y=20
SimpleScan som -1 0.1 20 5

sy send PR`=25000
sy send BG`
sampletitle x=0 y=20
SimpleScan som -1 0.1 20 5

sy send PR`=25000
sy send BG`
sampletitle x=10 y=20
SimpleScan som -1 0.1 20 5

sy send PR`=25000
sy send BG`
sampletitle x=20 y=20
SimpleScan som -1 0.1 20 5


# 3rd layer (7 points)
sphi send PR`=25000
sphi send BG`
sy send PR`=-125000
sy send BG`
sampletitle x=-30 y=10
SimpleScan som -1 0.1 20 5

sy send PR`=25000
sy send BG`
sampletitle x=-20 y=10
SimpleScan som -1 0.1 20 5

sy send PR`=25000
sy send BG`
sampletitle x=-10 y=10
SimpleScan som -1 0.1 20 5

sy send PR`=25000
sy send BG`
sampletitle x=0 y=10
SimpleScan som -1 0.1 20 5

sy send PR`=25000
sy send BG`
sampletitle x=10 y=10
SimpleScan som -1 0.1 20 5

sy send PR`=25000
sy send BG`
sampletitle x=20 y=10
SimpleScan som -1 0.1 20 5

sy send PR`=25000
sy send BG`
sampletitle x=30 y=10
SimpleScan som -1 0.1 20 5

# middle layer (7 points)

sphi send PR`=25000
sphi send BG`
sy send PR`=-150000
sy send BG`
sampletitle x=-30 y=00
SimpleScan som -1 0.1 20 5

sy send PR`=25000
sy send BG`
sampletitle x=-20 y=0
SimpleScan som -1 0.1 20 5

sy send PR`=25000
sy send BG`
sampletitle x=-10 y=0
SimpleScan som -1 0.1 20 5

sy send PR`=25000
sy send BG`
sampletitle x=0 y=0
SimpleScan som -1 0.1 20 5

sy send PR`=25000
sy send BG`
sampletitle x=10 y=0
SimpleScan som -1 0.1 20 5

sy send PR`=25000
sy send BG`
sampletitle x=20 y=0
SimpleScan som -1 0.1 20 5

sy send PR`=25000
sy send BG`
sampletitle x=30 y=0
SimpleScan som -1 0.1 20 5

sy send PR`=-75000
sy send BG`

