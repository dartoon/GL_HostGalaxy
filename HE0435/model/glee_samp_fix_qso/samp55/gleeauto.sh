#!/bin/bash

glee -M -i HE55

glee -h -H 100 HE55.mcmc
mv HE55.001 HE55_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE55_001 > HE55.001
glee -M -i HE55.001
./glee_chainout.sh
