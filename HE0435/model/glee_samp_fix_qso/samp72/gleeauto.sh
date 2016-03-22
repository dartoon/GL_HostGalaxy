#!/bin/bash

glee -M -i HE72

glee -h -H 100 HE72.mcmc
mv HE72.001 HE72_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE72_001 > HE72.001
glee -M -i HE72.001
./glee_chainout.sh
