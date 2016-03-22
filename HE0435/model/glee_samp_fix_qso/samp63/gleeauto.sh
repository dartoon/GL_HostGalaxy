#!/bin/bash

glee -M -i HE63

glee -h -H 100 HE63.mcmc
mv HE63.001 HE63_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE63_001 > HE63.001
glee -M -i HE63.001
./glee_chainout.sh
