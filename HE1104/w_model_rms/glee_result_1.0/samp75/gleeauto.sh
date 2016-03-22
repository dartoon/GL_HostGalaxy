#!/bin/bash

glee -M -i HE75

glee -h -H 20 HE75.mcmc
mv HE75.001 HE75_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE75_001 > HE75.001
glee -M -i HE75.001
./glee_chainout.sh
