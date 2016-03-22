#!/bin/bash

glee -M -i HE75

glee -h -H 100 HE75.mcmc
mv HE75.001 HE75_001
sed "s/ 7001/10000/g;s/0.02111/0.45/g" HE75_001 > HE75.001
glee -M -i HE75.001
./glee_chainout.sh
