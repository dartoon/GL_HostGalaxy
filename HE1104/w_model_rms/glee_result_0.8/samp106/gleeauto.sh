#!/bin/bash

glee -M -i HE106

glee -h -H 20 HE106.mcmc
mv HE106.001 HE106_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE106_001 > HE106.001
glee -M -i HE106.001
./glee_chainout.sh