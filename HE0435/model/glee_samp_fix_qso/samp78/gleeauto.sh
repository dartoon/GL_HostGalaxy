#!/bin/bash

glee -M -i HE78

glee -h -H 100 HE78.mcmc
mv HE78.001 HE78_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE78_001 > HE78.001
glee -M -i HE78.001
./glee_chainout.sh
