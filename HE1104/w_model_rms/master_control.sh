#!/bin/bash
cd glee_samp

for i in `seq 1 48`;do
      echo ${i}
      rm samp${i}/test_mag/galfit.*
      cp galfit.feedme samp${i}/test_mag
      #sed -i "/cd test_mag/d;/gal.sh/d" glee_chainout.sh 
      
done
