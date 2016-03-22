#!/bin/bash

glee -M -i HE38

glee -h -H 100 HE38.mcmc
mv HE38.001 HE38_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE38_001 > HE38.001
glee -M -i HE38.001
./glee_chainout.sh
