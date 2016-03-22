#!/bin/bash

glee -M -i HE3

glee -h -H 20 HE3.mcmc
mv HE3.001 HE3_001
sed "s/10001/15000/g;s/0.0511/0.55/g" HE3_001 > HE3.001
glee -M -i HE3.001
./glee_chainout.sh
