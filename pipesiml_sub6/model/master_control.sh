#!/bin/bash
cd glee_samp

for i in `seq 1 48`;do
      echo ${i}
      cd samp${i}
      sed -i "/cd test_mag/d;/gal.sh/d" glee_chainout.sh 
      cd ../
done
