#!/bin/bash
for i in `seq 1 4`;do
  cd samp${i}
  ./gleeauto.sh
  cd ..
  cp -r samp${i} ../glee_result
done
