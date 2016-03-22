#!/bin/bash

glee -M -i HE81

glee -h -H 100 HE81.mcmc
mv HE81.001 HE81_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE81_001 > HE81.001
glee -M -i HE81.001
./glee_chainout.sh
