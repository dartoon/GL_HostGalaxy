#!/bin/bash
cd glee_samp

for i in `seq 1 24`;do
      echo $(((${i}-1)*4+1))
      sed "s/HE/HE$(((${i}-1)*4+1))/g" ../gleeauto.sh > samp$(((${i}-1)*4+1))/gleeauto.sh
      #rm samp${i}/test_mag/galfit.*
      #cp galfit.feedme samp${i}/test_mag
      #sed -i "/cd test_mag/d;/gal.sh/d" glee_chainout.sh 
      
done