#!/bin/bash

glee -M -i HE10

glee -h -H 20 HE10.mcmc
mv HE10.001 HE10_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE10_001 > HE10.001
glee -M -i HE10.001
./glee_chainout.sh
