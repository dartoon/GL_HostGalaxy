#!/bin/bash
cd glee_samp

for i in `seq 1 6`;do
  for j in `seq 1 4`;do
      echo $(((${i}-1)*8+${j}+4))
      cd samp$(((${i}-1)*8+${j}+4))
     #sed -i "/cd test_mag/d;/gal.sh/d" glee_chainout.sh 
      cd test_mag
      cp ../../galfit.feedme ./
    # echo $(((${i}-1)*8+${j}))
      cd ../../
  done
done
