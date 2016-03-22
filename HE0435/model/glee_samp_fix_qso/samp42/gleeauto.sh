#!/bin/bash

glee -M -i HE42

glee -h -H 100 HE42.mcmc
mv HE42.001 HE42_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE42_001 > HE42.001
glee -M -i HE42.001
./glee_chainout.sh
