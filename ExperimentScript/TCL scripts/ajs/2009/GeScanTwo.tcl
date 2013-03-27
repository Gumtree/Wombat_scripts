MOtitle Ge stack in parallel plane 115 restart


samplename mtth= 90 115 1.54A
user ajs
email ajs@ansto.gov.au

# top layer (3 point)
'sphi send PR`=-75000
'sphi send BG`
'sy send PR`=-25000
'sy send BG`
sampletitle x=-10 y=30
SimpleScan som -1 0.1 20 5

sy send PR`=25000
sy send BG`
sampletitle x=0 y=30
SimpleScan som -1 0.1 20 5

sy send PR`=25000
sy send BG`
sampletitle x=10 y=30
SimpleScan som -1 0.1 20 5

