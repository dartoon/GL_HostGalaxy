#!/bin/bash

glee -M -i HE32

glee -h -H 100 HE32.mcmc
mv HE32.001 HE32_001
sed "s/ 7001/10000/g;s/0.02111/0.45/g" HE32_001 > HE32.001
glee -M -i HE32.001
./glee_chainout.sh
