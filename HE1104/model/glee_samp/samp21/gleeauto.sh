#!/bin/bash

glee -M -i HE21

glee -h -H 100 HE21.mcmc
mv HE21.001 HE21_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE21_001 > HE21.001
glee -M -i HE21.001
./glee_chainout.sh
