#!/bin/bash
#cd glee_samp
for i in `seq 17 24`;do
      j=$(((${i}-1)*4+1))
      cd samp${j}
      echo ${j}
      sed -i "s/0.25/0.15/g" gleeauto.sh 
      cd ..     
      
      #rm samp${i}/test_mag/galfit.*
      #cp galfit.feedme samp${i}/test_mag
      #sed -i "/cd test_mag/d;/gal.sh/d" glee_chainout.sh 
      #cp ../../simulation/fits/final/mask-${i}.fits samp${i}      
done
