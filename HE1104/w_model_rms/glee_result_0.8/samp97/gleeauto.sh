#!/bin/bash

glee -M -i HE97

glee -h -H 20 HE97.mcmc
mv HE97.001 HE97_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE97_001 > HE97.001
glee -M -i HE97.001
./glee_chainout.sh
