#!/bin/bash

#glee -M -i HE4

glee -h -H 100 HE4.mcmc
mv HE4.001 HE4_001
sed "s/ 7001/10000/g;s/0.02111/0.45/g" HE4_001 > HE4.001
glee -M -i HE4.001
./glee_chainout.sh
