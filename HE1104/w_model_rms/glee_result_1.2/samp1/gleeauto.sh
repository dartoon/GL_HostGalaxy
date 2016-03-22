#!/bin/bash

glee -M -i HE1

glee -h -H 20 HE1.mcmc
mv HE1.001 HE1_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE1_001 > HE1.001
glee -M -i HE1.001
./glee_chainout.sh
