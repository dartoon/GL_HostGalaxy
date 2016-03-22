#!/bin/bash

#glee -M -i HE2

glee -h -H 100 HE2.mcmc
mv HE2.001 HE2_001
sed "s/ 7001/10000/g;s/0.02111/0.45/g" HE2_001 > HE2.001
glee -M -i HE2.001
./glee_chainout.sh
