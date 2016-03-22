#!/bin/bash
for i in `seq 1 4`;do
  j=$((${i}+20*4))
  echo ${j}
  cd samp${j}
  ./gleeauto.sh
  cd ..
  cp -r samp${j}/mag_HE${j} ../glee_result/
done
