#!/bin/bash
for i in `seq 5 6`;do
  j=$((16*(${i}-1)+3))
  #echo ${j}
  cd samp${j}
  ./gleeauto.sh
  cd ..
  cp -r samp${j}/mag_HE${j} ../glee_result/
done
