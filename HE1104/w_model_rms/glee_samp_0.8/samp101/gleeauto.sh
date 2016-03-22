#!/bin/bash

glee -M -i HE101

glee -h -H 20 HE101.mcmc
mv HE101.001 HE101_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE101_001 > HE101.001
glee -M -i HE101.001
./glee_chainout.sh
