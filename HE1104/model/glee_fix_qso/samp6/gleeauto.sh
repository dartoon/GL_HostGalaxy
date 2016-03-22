#!/bin/bash

#glee -M -i HE6

glee -h -H 100 HE6.mcmc
mv HE6.001 HE6_001
sed "s/ 7001/10000/g;s/0.02111/0.45/g" HE6_001 > HE6.001
glee -M -i HE6.001
./glee_chainout.sh
