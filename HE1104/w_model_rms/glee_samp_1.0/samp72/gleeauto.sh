#!/bin/bash

glee -M -i HE72

glee -h -H 20 HE72.mcmc
mv HE72.001 HE72_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE72_001 > HE72.001
glee -M -i HE72.001
./glee_chainout.sh
