#!/bin/bash
for i in `seq 141 144`;do
  cd samp${i}
  ./gleeauto.sh
  cd ..
  cp -r samp${i}/mag_HE${i} ../glee_result/
done
