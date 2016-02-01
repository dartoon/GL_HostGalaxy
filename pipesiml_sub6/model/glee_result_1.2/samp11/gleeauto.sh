#!/bin/bash

glee -M -i HE11

glee -h -H 20 HE11.mcmc
mv HE11.001 HE11_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE11_001 > HE11.001
glee -M -i HE11.001
./glee_chainout.sh
