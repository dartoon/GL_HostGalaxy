#!/bin/bash
for i in `seq 1 48`;do
 # for j in `seq 1 4`;do
     cd samp${i}/test_mag
     mv rms_resualt_gal rms_result_gal
     #mv result_gal f_result_gal
     #cp ../../galfit.feedme ./
     #./gal.sh
     cd ../../
     #echo $(((${i}-1)*4+j))
 # done
done
