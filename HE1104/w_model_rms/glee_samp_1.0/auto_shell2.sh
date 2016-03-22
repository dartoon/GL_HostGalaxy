#!/bin/bash
for i in `seq 53 56`;do
  cd samp${i}
  ./gleeauto.sh
  cd ..
  cp -r samp${i} ../glee_result_1.0/
done
