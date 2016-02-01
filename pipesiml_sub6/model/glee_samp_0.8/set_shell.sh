#!/bin/bash
for j in `seq 1 12`;do
  sed "s/seq 1 4/seq $((48*2+1+4*(${j}-1))) $((48*2+4+4*(${j}-1)))/g" auto_shell.sh > auto_0.8_shell${j}.sh
done
