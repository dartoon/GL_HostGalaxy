#!/bin/bash

glee -M -i HE76

glee -h -H 100 HE76.mcmc
mv HE76.001 HE76_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE76_001 > HE76.001
glee -M -i HE76.001
./glee_chainout.sh
