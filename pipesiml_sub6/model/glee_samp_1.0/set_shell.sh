#!/bin/bash
for j in `seq 1 12`;do
  sed "s/seq 1 4/seq $((48+1+4*(${j}-1))) $((48+4+4*(${j}-1)))/g" auto_shell.sh > auto_shell${j}.sh
done
