#!/bin/bash

glee -M -i HE65

glee -h -H 100 HE65.mcmc
mv HE65.001 HE65_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE65_001 > HE65.001
glee -M -i HE65.001
./glee_chainout.sh
