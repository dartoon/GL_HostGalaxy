#!/bin/bash

glee -M -i HE110

glee -h -H 20 HE110.mcmc
mv HE110.001 HE110_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE110_001 > HE110.001
glee -M -i HE110.001
./glee_chainout.sh
