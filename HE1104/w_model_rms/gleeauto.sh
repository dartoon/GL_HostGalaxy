#!/bin/bash

glee -M -i HE

glee -h -H 20 HE.mcmc
mv HE.001 HE_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE_001 > HE.001
glee -M -i HE.001
./glee_chainout.sh