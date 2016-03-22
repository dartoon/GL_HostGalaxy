#!/bin/bash

glee -M -i HE62

glee -h -H 100 HE62.mcmc
mv HE62.001 HE62_001
sed "s/ 7001/10000/g;s/0.02111/0.45/g" HE62_001 > HE62.001
glee -M -i HE62.001
./glee_chainout.sh
