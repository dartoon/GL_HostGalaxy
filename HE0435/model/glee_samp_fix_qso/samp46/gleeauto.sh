#!/bin/bash

glee -M -i HE46

glee -h -H 100 HE46.mcmc
mv HE46.001 HE46_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE46_001 > HE46.001
glee -M -i HE46.001
./glee_chainout.sh
