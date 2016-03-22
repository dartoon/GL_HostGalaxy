#!/bin/bash

glee -M -i HE9

glee -h -H 100 HE9.mcmc
mv HE9.001 HE9_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE9_001 > HE9.001
glee -M -i HE9.001
./glee_chainout.sh
