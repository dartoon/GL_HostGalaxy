#!/bin/bash

glee -M -i HE41

glee -h -H 100 HE41.mcmc
mv HE41.001 HE41_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE41_001 > HE41.001
glee -M -i HE41.001
./glee_chainout.sh
