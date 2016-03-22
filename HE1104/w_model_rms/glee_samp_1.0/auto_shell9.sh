#!/bin/bash
for i in `seq 81 84`;do
  cd samp${i}
  ./gleeauto.sh
  cd ..
  cp -r samp${i} ../glee_result_1.0/
done
