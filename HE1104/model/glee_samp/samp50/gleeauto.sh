#!/bin/bash

glee -M -i HE50

glee -h -H 100 HE50.mcmc
mv HE50.001 HE50_001
sed "s/ 7001/10000/g;s/0.02111/0.45/g" HE50_001 > HE50.001
glee -M -i HE50.001
./glee_chainout.sh
