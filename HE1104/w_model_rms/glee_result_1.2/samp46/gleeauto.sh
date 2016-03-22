#!/bin/bash

glee -M -i HE46

glee -h -H 20 HE46.mcmc
mv HE46.001 HE46_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE46_001 > HE46.001
glee -M -i HE46.001
./glee_chainout.sh
