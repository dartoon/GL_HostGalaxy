#!/bin/bash
for i in `seq 137 140`;do
  cd samp${i}
  ./gleeauto.sh
  cd ..
  cp -r samp${i} ../glee_result_0.8/
done
