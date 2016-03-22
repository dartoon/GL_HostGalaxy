#!/bin/bash

glee -M -i HE13

glee -h -H 100 HE13.mcmc
mv HE13.001 HE13_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE13_001 > HE13.001
glee -M -i HE13.001
./glee_chainout.sh
