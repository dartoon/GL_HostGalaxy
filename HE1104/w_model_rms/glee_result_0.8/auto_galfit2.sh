#!/bin/bash
#auto set the config in of test_mag
for i in `seq 97 144`;do
      #echo $(((${i}-1)*4+${j}))
      cp ../test_mag_norms/* samp${i}/test_mag
done

#auto set the galfit_n.feedme in of test_mag. To galfit with a fixed n
for i in `seq 1 6`;do
  for j in `seq 1 4`;do
      echo $(((${i}-1)*8+${j}+48*2))
      cd samp$(((${i}-1)*8+${j}+48*2))     
      cd test_mag
      sed "s/5) 2.0000      1/5) 2.0000      0/g" galfit.feedme > galfit_n.feedme   
      cd ../../
  done
done
for i in `seq 1 6`;do
  for j in `seq 1 4`;do
      echo $(((${i}-1)*8+${j}+4+48*2))
      cd samp$(((${i}-1)*8+${j}+4+48*2))
      cd test_mag
      sed "s/5) 2.0000      1/5) 4.0000      0/g" galfit.feedme > galfit_n.feedme   
      cd ../../
  done
done

