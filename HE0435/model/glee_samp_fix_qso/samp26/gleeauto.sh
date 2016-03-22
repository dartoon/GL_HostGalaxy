#!/bin/bash

glee -M -i HE26

glee -h -H 100 HE26.mcmc
mv HE26.001 HE26_001
sed "s/ 7001/20000/g;s/0.02111/0.4/g" HE26_001 > HE26.001
glee -M -i HE26.001
./glee_chainout.sh
