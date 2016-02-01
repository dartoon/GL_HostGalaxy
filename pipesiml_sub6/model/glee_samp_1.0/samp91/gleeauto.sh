#!/bin/bash

glee -M -i HE91

glee -h -H 20 HE91.mcmc
mv HE91.001 HE91_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE91_001 > HE91.001
glee -M -i HE91.001
./glee_chainout.sh
