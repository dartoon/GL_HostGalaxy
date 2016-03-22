#!/bin/bash

glee -M -i HE17

glee -h -H 100 HE17.mcmc
mv HE17.001 HE17_001
sed "s/ 7001/20000/g;s/0.02111/0.4/g" HE17_001 > HE17.001
glee -M -i HE17.001
./glee_chainout.sh
