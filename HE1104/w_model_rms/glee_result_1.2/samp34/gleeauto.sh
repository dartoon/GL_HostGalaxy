#!/bin/bash

glee -M -i HE34

glee -h -H 20 HE34.mcmc
mv HE34.001 HE34_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE34_001 > HE34.001
glee -M -i HE34.001
./glee_chainout.sh
