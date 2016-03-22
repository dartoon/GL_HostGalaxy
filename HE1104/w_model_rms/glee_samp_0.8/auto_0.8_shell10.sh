#!/bin/bash
for i in `seq 133 136`;do
  cd samp${i}
  ./gleeauto.sh
  cd ..
  cp -r samp${i} ../glee_result_0.8/
done
