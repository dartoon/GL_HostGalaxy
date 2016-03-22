#!/bin/bash

glee -M -i HE85

glee -h -H 100 HE85.mcmc
mv HE85.001 HE85_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE85_001 > HE85.001
glee -M -i HE85.001
./glee_chainout.sh
