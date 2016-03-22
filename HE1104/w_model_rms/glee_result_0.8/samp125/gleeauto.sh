#!/bin/bash

glee -M -i HE125

glee -h -H 20 HE125.mcmc
mv HE125.001 HE125_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE125_001 > HE125.001
glee -M -i HE125.001
./glee_chainout.sh
