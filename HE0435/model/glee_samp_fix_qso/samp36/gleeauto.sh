#!/bin/bash

glee -M -i HE36

glee -h -H 100 HE36.mcmc
mv HE36.001 HE36_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE36_001 > HE36.001
glee -M -i HE36.001
./glee_chainout.sh
