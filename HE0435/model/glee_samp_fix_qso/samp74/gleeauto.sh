#!/bin/bash

glee -M -i HE74

glee -h -H 100 HE74.mcmc
mv HE74.001 HE74_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE74_001 > HE74.001
glee -M -i HE74.001
./glee_chainout.sh
