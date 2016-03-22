#!/bin/bash
for i in `seq 61 64`;do
  cd samp${i}
  ./gleeauto.sh
  cd ..
  cp -r samp${i} ../glee_result_1.0/
done
