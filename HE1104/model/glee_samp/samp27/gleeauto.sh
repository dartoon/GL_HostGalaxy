#!/bin/bash

glee -M -i HE27

glee -h -H 100 HE27.mcmc
mv HE27.001 HE27_001
sed "s/ 7001/10000/g;s/0.02111/0.45/g" HE27_001 > HE27.001
glee -M -i HE27.001
./glee_chainout.sh
