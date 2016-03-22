#!/bin/bash

glee -M -i HE93

glee -h -H 20 HE93.mcmc
mv HE93.001 HE93_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE93_001 > HE93.001
glee -M -i HE93.001
./glee_chainout.sh
