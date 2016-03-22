#!/bin/bash

glee -M -i HE79

glee -h -H 100 HE79.mcmc
mv HE79.001 HE79_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE79_001 > HE79.001
glee -M -i HE79.001
./glee_chainout.sh
