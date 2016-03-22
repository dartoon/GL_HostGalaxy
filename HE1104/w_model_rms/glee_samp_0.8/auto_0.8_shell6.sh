#!/bin/bash
for i in `seq 117 120`;do
  cd samp${i}
  ./gleeauto.sh
  cd ..
  cp -r samp${i} ../glee_result_0.8/
done
