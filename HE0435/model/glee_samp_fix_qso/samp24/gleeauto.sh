#!/bin/bash

glee -M -i HE24

glee -h -H 100 HE24.mcmc
mv HE24.001 HE24_001
sed "s/ 7001/20000/g;s/0.02111/0.4/g" HE24_001 > HE24.001
glee -M -i HE24.001
./glee_chainout.sh
