#!/bin/bash
for i in `seq 77 80`;do
  cd samp${i}
  ./gleeauto.sh
  cd ..
  cp -r samp${i} ../glee_result_1.0/
done