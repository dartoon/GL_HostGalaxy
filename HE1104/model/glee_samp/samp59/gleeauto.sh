#!/bin/bash

glee -M -i HE59

glee -h -H 100 HE59.mcmc
mv HE59.001 HE59_001
sed "s/ 7001/10000/g;s/0.02111/0.45/g" HE59_001 > HE59.001
glee -M -i HE59.001
./glee_chainout.sh
