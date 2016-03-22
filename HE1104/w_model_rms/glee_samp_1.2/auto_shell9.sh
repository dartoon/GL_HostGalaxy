#!/bin/bash
for i in `seq 2 4`;do
  cd samp$((${i}+32))
  ./gleeauto.sh
  cd ..
  #echo $((${i}+4))
done
