#!/bin/bash

glee -M -i HE77

glee -h -H 100 HE77.mcmc
mv HE77.001 HE77_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE77_001 > HE77.001
glee -M -i HE77.001
./glee_chainout.sh
