#!/bin/bash
for i in `seq 1 48`;do
 # for j in `seq 1 4`;do
     cd samp${i}/test_mag
     mv result_fix_n f_result_fix_n
     mv result_gal f_result_gal
     #cp ../../galfit.feedme ./
     #./gal.sh
     cd ../../
     #echo $(((${i}-1)*4+j))
 # done
done
