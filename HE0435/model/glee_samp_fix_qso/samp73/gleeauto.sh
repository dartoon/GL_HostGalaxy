#!/bin/bash

glee -M -i HE73

glee -h -H 100 HE73.mcmc
mv HE73.001 HE73_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE73_001 > HE73.001
glee -M -i HE73.001
./glee_chainout.sh
