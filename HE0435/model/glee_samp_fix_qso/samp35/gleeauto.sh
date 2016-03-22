#!/bin/bash

glee -M -i HE35

glee -h -H 100 HE35.mcmc
mv HE35.001 HE35_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE35_001 > HE35.001
glee -M -i HE35.001
./glee_chainout.sh
