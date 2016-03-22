#!/bin/bash

glee -M -i HE40

glee -h -H 100 HE40.mcmc
mv HE40.001 HE40_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE40_001 > HE40.001
glee -M -i HE40.001
./glee_chainout.sh
