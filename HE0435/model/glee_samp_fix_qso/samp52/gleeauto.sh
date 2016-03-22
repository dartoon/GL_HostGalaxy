#!/bin/bash

glee -M -i HE52

glee -h -H 100 HE52.mcmc
mv HE52.001 HE52_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE52_001 > HE52.001
glee -M -i HE52.001
./glee_chainout.sh
