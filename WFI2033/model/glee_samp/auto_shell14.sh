#!/bin/bash
for i in `seq 1 6`;do
  j=$(($(((${i}-1)*16))+14))
  echo ${j}
  cd samp${j}
  ./gleeauto.sh
  cd ..
  cp -r samp${j}/mag_HE${j} ../glee_result/
done
