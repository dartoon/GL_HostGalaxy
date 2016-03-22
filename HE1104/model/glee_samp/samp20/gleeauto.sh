#!/bin/bash

glee -M -i HE20

glee -h -H 100 HE20.mcmc
mv HE20.001 HE20_001
sed "s/ 7001/10000/g;s/0.02111/0.45/g" HE20_001 > HE20.001
glee -M -i HE20.001
./glee_chainout.sh
