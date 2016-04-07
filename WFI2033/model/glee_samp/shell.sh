#!/bin/bash
for j in `seq 2 16`;do
  #k=$((${j}-1))
  sed "s/+1/+${j}/g" auto_shell1.sh > auto_shell${j}.sh
done
