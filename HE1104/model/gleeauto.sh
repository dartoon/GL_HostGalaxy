#!/bin/bash

glee -M -i HE

glee -h -H 100 HE.mcmc
mv HE.001 HE_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE_001 > HE.001
glee -M -i HE.001
./glee_chainout.sh
