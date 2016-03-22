#!/bin/bash

glee -M -i HE82

glee -h -H 100 HE82.mcmc
mv HE82.001 HE82_001
sed "s/ 7001/10000/g;s/0.02111/0.45/g" HE82_001 > HE82.001
glee -M -i HE82.001
./glee_chainout.sh
