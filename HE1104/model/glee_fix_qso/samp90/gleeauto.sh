#!/bin/bash

glee -M -i HE90

glee -h -H 100 HE90.mcmc
mv HE90.001 HE90_001
sed "s/ 7001/10000/g;s/0.02111/0.45/g" HE90_001 > HE90.001
glee -M -i HE90.001
./glee_chainout.sh
