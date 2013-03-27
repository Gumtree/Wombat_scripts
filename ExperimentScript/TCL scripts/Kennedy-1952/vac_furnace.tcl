title proposal 1952
# temperature controller craziness requires this
emon unregister tc1
broadcast "emon behaves"

sampledescription mtth115-Ge335-335-VacFurn
user Teck Yee Tan

tc1 tolerance 5
tc1 ramprate 500

#-- List of temperatures going up
proc runtemps_up {} {
       set templist [list 110 150 200 250 300 350 375 400 415 430 445 460 475 490 500 530 550 575 600 625 650 675 685 700 715 730 745 760 775 790 800 825 850  ]
       foreach cel_temperature $templist {
	       samplename [ concat Ca04Sr04Nd02Mn95Cr05O3, $cel_temperature C heating up]
	       # adjust West 400 max power to improve stability
	       tc1 PowerLimit [expr $cel_temperature/15]
	       drive tc1 $cel_temperature
	       wait 600
	       radcollrun 15 1
       }
}

# now run
runtemps_up
# now cool down
tc1 powerlimit 8
tc1 ramprate 10000
tc1 setpoint 20
samplename Ca04Sr04Nd02Mn95Cr05O3 cooling after heating to 850
# collect dat as we cool
radcollrun 15 12