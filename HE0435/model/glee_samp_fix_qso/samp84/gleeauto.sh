#!/bin/bash

glee -M -i HE84

glee -h -H 100 HE84.mcmc
mv HE84.001 HE84_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE84_001 > HE84.001
glee -M -i HE84.001
./glee_chainout.sh
