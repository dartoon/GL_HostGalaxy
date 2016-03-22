#!/bin/bash

glee -M -i HE4

glee -h -H 20 HE4.mcmc
mv HE4.001 HE4_001
sed "s/10001/15000/g;s/0.0511/0.55/g" HE4_001 > HE4.001
glee -M -i HE4.001
./glee_chainout.sh
