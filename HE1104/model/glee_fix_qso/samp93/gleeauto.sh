#!/bin/bash

glee -M -i HE93

glee -h -H 100 HE93.mcmc
mv HE93.001 HE93_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE93_001 > HE93.001
glee -M -i HE93.001
./glee_chainout.sh
