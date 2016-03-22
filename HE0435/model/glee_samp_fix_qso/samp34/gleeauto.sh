#!/bin/bash

glee -M -i HE34

glee -h -H 100 HE34.mcmc
mv HE34.001 HE34_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE34_001 > HE34.001
glee -M -i HE34.001
./glee_chainout.sh
