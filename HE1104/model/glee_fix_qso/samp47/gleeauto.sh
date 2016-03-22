#!/bin/bash

glee -M -i HE47

glee -h -H 100 HE47.mcmc
mv HE47.001 HE47_001
sed "s/ 7001/10000/g;s/0.02111/0.45/g" HE47_001 > HE47.001
glee -M -i HE47.001
./glee_chainout.sh
