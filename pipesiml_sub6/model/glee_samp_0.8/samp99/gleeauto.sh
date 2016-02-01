#!/bin/bash

glee -M -i HE99

glee -h -H 20 HE99.mcmc
mv HE99.001 HE99_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE99_001 > HE99.001
glee -M -i HE99.001
./glee_chainout.sh
