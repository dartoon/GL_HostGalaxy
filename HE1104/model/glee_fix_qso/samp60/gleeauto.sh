#!/bin/bash

glee -M -i HE60

glee -h -H 100 HE60.mcmc
mv HE60.001 HE60_001
sed "s/ 7001/10000/g;s/0.02111/0.45/g" HE60_001 > HE60.001
glee -M -i HE60.001
./glee_chainout.sh
