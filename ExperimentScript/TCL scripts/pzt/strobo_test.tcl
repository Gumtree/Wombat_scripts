title PZT 2D 1.77kV bipolar 0p01HZ 64 bin redo TEST
sampletitle postive initial 
samplename EC65 2D
user jones
email ajs@ansto.gov.au

#histmem_period_strobo 100 64
#NOTE: CHECK VALUE FOR CLOCK_SCALE
#CURRENTLY BASED ON 1 MILLION NANOSECS
# IE ONE MILLISEC


#OAT_TABLE -set T {0 1562} NTC 64
#histmem fsrce EXTERNAL
#histmem loadconf

SetRadColl 60 2
RadCollRun 3 2 
#SimpleScan som 24.5 0.1 15 10


