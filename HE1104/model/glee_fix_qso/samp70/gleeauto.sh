#!/bin/bash

glee -M -i HE70

glee -h -H 100 HE70.mcmc
mv HE70.001 HE70_001
sed "s/ 7001/10000/g;s/0.02111/0.45/g" HE70_001 > HE70.001
glee -M -i HE70.001
./glee_chainout.sh
