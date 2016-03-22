#!/bin/bash

glee -M -i HE5

glee -h -H 100 HE5.mcmc
mv HE5.001 HE5_001
sed "s/ 7001/20000/g;s/0.02111/0.3/g" HE5_001 > HE5.001
glee -M -i HE5.001
./glee_chainout.sh
