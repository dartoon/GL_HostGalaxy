#!/bin/bash
for j in `seq 17 24`;do
  k=$((${j}-1))
  sed "s/0/${k}/g" auto_shell1.sh > auto_shell${j}.sh
done
