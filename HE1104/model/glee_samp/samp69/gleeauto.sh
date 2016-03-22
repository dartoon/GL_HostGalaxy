#!/bin/bash

glee -M -i HE69

glee -h -H 100 HE69.mcmc
mv HE69.001 HE69_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE69_001 > HE69.001
glee -M -i HE69.001
./glee_chainout.sh
