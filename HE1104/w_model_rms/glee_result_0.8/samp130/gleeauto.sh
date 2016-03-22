#!/bin/bash

glee -M -i HE130

glee -h -H 20 HE130.mcmc
mv HE130.001 HE130_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE130_001 > HE130.001
glee -M -i HE130.001
./glee_chainout.sh
