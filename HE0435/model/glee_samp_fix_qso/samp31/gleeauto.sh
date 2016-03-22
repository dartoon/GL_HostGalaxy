#!/bin/bash

glee -M -i HE31

glee -h -H 100 HE31.mcmc
mv HE31.001 HE31_001
sed "s/ 7001/20000/g;s/0.02111/0.4/g" HE31_001 > HE31.001
glee -M -i HE31.001
./glee_chainout.sh
