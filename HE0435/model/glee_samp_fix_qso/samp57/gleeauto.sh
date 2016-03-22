#!/bin/bash

glee -M -i HE57

glee -h -H 100 HE57.mcmc
mv HE57.001 HE57_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE57_001 > HE57.001
glee -M -i HE57.001
./glee_chainout.sh
