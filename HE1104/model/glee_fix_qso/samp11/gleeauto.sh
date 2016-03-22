#!/bin/bash

glee -M -i HE11

glee -h -H 100 HE11.mcmc
mv HE11.001 HE11_001
sed "s/ 7001/10000/g;s/0.02111/0.45/g" HE11_001 > HE11.001
glee -M -i HE11.001
./glee_chainout.sh
