#!/bin/bash

glee -M -i HE80

glee -h -H 100 HE80.mcmc
mv HE80.001 HE80_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE80_001 > HE80.001
glee -M -i HE80.001
./glee_chainout.sh
