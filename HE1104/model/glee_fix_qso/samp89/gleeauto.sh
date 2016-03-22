#!/bin/bash

glee -M -i HE89

glee -h -H 100 HE89.mcmc
mv HE89.001 HE89_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE89_001 > HE89.001
glee -M -i HE89.001
./glee_chainout.sh
