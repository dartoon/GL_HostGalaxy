#!/bin/bash

glee -M -i HE61

glee -h -H 100 HE61.mcmc
mv HE61.001 HE61_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE61_001 > HE61.001
glee -M -i HE61.001
./glee_chainout.sh
