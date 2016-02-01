#!/bin/bash

glee -M -i HE39

glee -h -H 20 HE39.mcmc
mv HE39.001 HE39_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE39_001 > HE39.001
glee -M -i HE39.001
./glee_chainout.sh
