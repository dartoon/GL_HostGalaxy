#!/bin/bash

glee -M -i HE138

glee -h -H 20 HE138.mcmc
mv HE138.001 HE138_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE138_001 > HE138.001
glee -M -i HE138.001
./glee_chainout.sh
