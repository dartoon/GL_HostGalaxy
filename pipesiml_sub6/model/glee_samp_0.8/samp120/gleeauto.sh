#!/bin/bash

glee -M -i HE120

glee -h -H 20 HE120.mcmc
mv HE120.001 HE120_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE120_001 > HE120.001
glee -M -i HE120.001
./glee_chainout.sh
