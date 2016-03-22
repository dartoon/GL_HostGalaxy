#!/bin/bash

glee -M -i HE83

glee -h -H 100 HE83.mcmc
mv HE83.001 HE83_001
sed "s/ 7001/10000/g;s/0.02111/0.45/g" HE83_001 > HE83.001
glee -M -i HE83.001
./glee_chainout.sh
