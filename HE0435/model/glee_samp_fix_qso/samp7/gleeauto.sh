#!/bin/bash

glee -M -i HE7

glee -h -H 100 HE7.mcmc
mv HE7.001 HE7_001
sed "s/ 7001/20000/g;s/0.02111/0.4/g" HE7_001 > HE7.001
glee -M -i HE7.001
./glee_chainout.sh
