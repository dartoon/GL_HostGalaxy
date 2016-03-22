#!/bin/bash

glee -M -i HE112

glee -h -H 20 HE112.mcmc
mv HE112.001 HE112_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE112_001 > HE112.001
glee -M -i HE112.001
./glee_chainout.sh
