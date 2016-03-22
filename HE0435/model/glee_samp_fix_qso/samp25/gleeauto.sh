#!/bin/bash

glee -M -i HE25

glee -h -H 100 HE25.mcmc
mv HE25.001 HE25_001
sed "s/ 7001/20000/g;s/0.02111/0.4/g" HE25_001 > HE25.001
glee -M -i HE25.001
./glee_chainout.sh
