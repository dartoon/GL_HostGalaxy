#!/bin/bash
for i in `seq 3 4`;do
  cd samp$((${i}+44))
  ./gleeauto.sh
  cd ..
  #echo $((${i}+4))
done
