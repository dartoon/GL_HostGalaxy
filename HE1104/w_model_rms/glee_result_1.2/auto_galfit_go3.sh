#!/bin/bash
#initialize samp{*} test_mag,
for i in `seq 25 36`;do
  #for j in `seq 1 2`;do
     cd samp${i}
     cd test_mag
     #mv f_result_fix_n rms_result_fix_n
     #mv f_result_gal rms_resualt_gal
     ./gal.sh
     cd ../../
     #echo $(((${i}-1)*4+j))
  #done
done
