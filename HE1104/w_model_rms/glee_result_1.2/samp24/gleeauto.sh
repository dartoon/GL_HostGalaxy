#!/bin/bash

glee -M -i HE24

glee -h -H 20 HE24.mcmc
mv HE24.001 HE24_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE24_001 > HE24.001
glee -M -i HE24.001
./glee_chainout.sh
