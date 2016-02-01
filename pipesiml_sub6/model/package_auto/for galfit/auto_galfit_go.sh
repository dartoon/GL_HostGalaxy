#!/bin/bash
#initialize samp{*} test_mag,
for i in `seq 1 48`;do
  #for j in `seq 1 2`;do
     cd samp${i}
     cd test_mag
     ./gal.sh
     cd ../../
     #echo $(((${i}-1)*4+j))
  #done
done
