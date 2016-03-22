#!/bin/bash
for i in `seq 101 104`;do
  cd samp${i}
  ./gleeauto.sh
  cd ..
  cp -r samp${i} ../glee_result_0.8/
done
