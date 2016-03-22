#!/bin/bash

glee -M -i HE94

glee -h -H 20 HE94.mcmc
mv HE94.001 HE94_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE94_001 > HE94.001
glee -M -i HE94.001
./glee_chainout.sh
