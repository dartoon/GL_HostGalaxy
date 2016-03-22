#!/bin/bash

glee -M -i HE71

glee -h -H 100 HE71.mcmc
mv HE71.001 HE71_001
sed "s/ 7001/10000/g;s/0.02111/0.45/g" HE71_001 > HE71.001
glee -M -i HE71.001
./glee_chainout.sh
