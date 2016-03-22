#!/bin/bash
for i in `seq 45 48`;do
  cd samp${i}
  ./gleeauto.sh
  cd ..
  cp -r samp${i}/mag_HE${i} ../glee_result/
done
