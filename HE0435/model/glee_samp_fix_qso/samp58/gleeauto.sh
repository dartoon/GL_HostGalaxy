#!/bin/bash

glee -M -i HE58

glee -h -H 100 HE58.mcmc
mv HE58.001 HE58_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE58_001 > HE58.001
glee -M -i HE58.001
./glee_chainout.sh
