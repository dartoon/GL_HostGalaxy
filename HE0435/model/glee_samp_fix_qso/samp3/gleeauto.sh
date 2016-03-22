#!/bin/bash

glee -M -i HE3

glee -h -H 100 HE3.mcmc
mv HE3.001 HE3_001
sed "s/ 7001/20000/g;s/0.02111/0.4/g" HE3_001 > HE3.001
glee -M -i HE3.001
./glee_chainout.sh
