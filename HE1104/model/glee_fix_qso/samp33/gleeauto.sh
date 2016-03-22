#!/bin/bash

glee -M -i HE33

glee -h -H 100 HE33.mcmc
mv HE33.001 HE33_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE33_001 > HE33.001
glee -M -i HE33.001
./glee_chainout.sh