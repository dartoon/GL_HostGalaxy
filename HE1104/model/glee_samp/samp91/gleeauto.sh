#!/bin/bash

glee -M -i HE91

glee -h -H 100 HE91.mcmc
mv HE91.001 HE91_001
sed "s/ 7001/10000/g;s/0.02111/0.45/g" HE91_001 > HE91.001
glee -M -i HE91.001
./glee_chainout.sh
