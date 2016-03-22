#!/bin/bash

glee -M -i HE86

glee -h -H 20 HE86.mcmc
mv HE86.001 HE86_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE86_001 > HE86.001
glee -M -i HE86.001
./glee_chainout.sh
