#!/bin/bash

glee -M -i HE54

glee -h -H 100 HE54.mcmc
mv HE54.001 HE54_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE54_001 > HE54.001
glee -M -i HE54.001
./glee_chainout.sh
