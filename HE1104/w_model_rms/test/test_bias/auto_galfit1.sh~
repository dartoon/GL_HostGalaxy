#!/bin/bash
#initialize samp{*} test_mag,
#python flux.py
for i in `seq 1 10`;do
     cd samp${i}
     cd test_mag     
     #rm galfit.*
     #cp ../../gal.sh ../../galfit.feedme ./
     #cp ../../galoutp.py ./ 
     cp ../../galfit.feedme ../../galfit_n.feedme ./
     mv f_result_fix_n rms_result_fix_n
     mv f_result_gal rms_result_gal
     ./gal.sh
     cd ../../
     #echo $(((${i}-1)*4+j))
done
