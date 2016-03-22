#!/bin/bash

glee -M -i HE8

glee -h -H 100 HE8.mcmc
mv HE8.001 HE8_001
sed "s/ 7001/20000/g;s/0.02111/0.4/g" HE8_001 > HE8.001
glee -M -i HE8.001
./glee_chainout.sh
