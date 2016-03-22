#!/bin/bash

glee -M -i HE94

glee -h -H 100 HE94.mcmc
mv HE94.001 HE94_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE94_001 > HE94.001
glee -M -i HE94.001
./glee_chainout.sh
