#!/bin/bash

glee -M -i HE2

glee -h -H 20 HE2.mcmc
mv HE2.001 HE2_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE2_001 > HE2.001
glee -M -i HE2.001
./glee_chainout.sh
