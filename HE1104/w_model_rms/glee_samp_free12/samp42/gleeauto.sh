#!/bin/bash

glee -M -i HE42

glee -h -H 20 HE42.mcmc
mv HE42.001 HE42_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE42_001 > HE42.001
glee -M -i HE42.001
./glee_chainout.sh
