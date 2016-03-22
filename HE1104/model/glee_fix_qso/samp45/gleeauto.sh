#!/bin/bash

glee -M -i HE45

glee -h -H 100 HE45.mcmc
mv HE45.001 HE45_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE45_001 > HE45.001
glee -M -i HE45.001
./glee_chainout.sh
