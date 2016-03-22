#!/bin/bash

glee -M -i HE56

glee -h -H 100 HE56.mcmc
mv HE56.001 HE56_001
sed "s/ 7001/10000/g;s/0.02111/0.45/g" HE56_001 > HE56.001
glee -M -i HE56.001
./glee_chainout.sh
