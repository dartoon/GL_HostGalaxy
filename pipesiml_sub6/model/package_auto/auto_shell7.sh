#!/bin/bash
for i in `seq 1 4`;do
  cd samp$((${i}+24))
  ./gleeauto.sh
  cd ..
  #echo $((${i}+4))
done
