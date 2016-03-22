#!/bin/bash

glee -M -i HE43

glee -h -H 100 HE43.mcmc
mv HE43.001 HE43_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE43_001 > HE43.001
glee -M -i HE43.001
./glee_chainout.sh
