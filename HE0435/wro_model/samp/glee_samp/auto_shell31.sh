#!/bin/bash
for i in `seq 121 124`;do
  cd samp${i}
  ./gleeauto.sh
  cd ..
  cp -r samp${i}/mag_HE${i} ../glee_result/
done
