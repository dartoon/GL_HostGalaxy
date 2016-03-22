#!/bin/bash
for i in `seq 1 4`;do
  cd samp$((${i}+44))
  ./gleeauto.sh
  cd ..
  #echo $((${i}+4))
  cp -r samp${i} ../glee_result
done
