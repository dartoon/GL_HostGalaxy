#!/bin/bash
#initialize samp{*} test_mag,
for i in `seq 1 12`;do
  for j in `seq 1 4`;do
     cd samp$(((${i}-1)*4+${j}))
     cd test_mag
     rm galfit*
     rm result_*
     #cp ../../galfit.feedme ./
     #./gal.sh
     cd ../../
     #echo $(((${i}-1)*4+j))
  done
done
