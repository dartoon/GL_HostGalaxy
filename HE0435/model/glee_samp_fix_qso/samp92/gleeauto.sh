#!/bin/bash

glee -M -i HE92

glee -h -H 100 HE92.mcmc
mv HE92.001 HE92_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE92_001 > HE92.001
glee -M -i HE92.001
./glee_chainout.sh
