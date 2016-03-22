#!/bin/bash
for i in `seq 1 96`;do
	#sed "s/HE1/HE${i}/g" glee_chainout.sh > samp${i}/glee_chainout.sh
	mv samp${i}/mag_HE${i} result_mag
done  
