#!/bin/bash

glee -M -i HE49

glee -h -H 100 HE49.mcmc
mv HE49.001 HE49_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE49_001 > HE49.001
glee -M -i HE49.001
./glee_chainout.sh
