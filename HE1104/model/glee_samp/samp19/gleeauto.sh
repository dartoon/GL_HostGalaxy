#!/bin/bash

glee -M -i HE19

glee -h -H 100 HE19.mcmc
mv HE19.001 HE19_001
sed "s/ 7001/10000/g;s/0.02111/0.45/g" HE19_001 > HE19.001
glee -M -i HE19.001
./glee_chainout.sh
