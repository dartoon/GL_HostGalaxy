#!/bin/bash

glee -M -i HE30

glee -h -H 100 HE30.mcmc
mv HE30.001 HE30_001
sed "s/ 7001/20000/g;s/0.02111/0.4/g" HE30_001 > HE30.001
glee -M -i HE30.001
./glee_chainout.sh
