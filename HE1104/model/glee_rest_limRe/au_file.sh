#!/bin/bash
for i in `seq 17 32`;do        #the number of parameter 
   #mkdir mag_HE${i}
   #cp ../glee_result/mag_HE${i}/gal*.fits ../glee_result/mag_HE${i}/galfit_n.feedme mag_HE${i}
   cp test_mag_norms/fix_re_gal.py mag_HE$((${i}+32*2))
done
