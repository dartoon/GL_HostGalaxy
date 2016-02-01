#!/bin/bash

glee -M -i HE5

glee -h -H 20 HE5.mcmc
mv HE5.001 HE5_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE5_001 > HE5.001
glee -M -i HE5.001
./glee_chainout.sh
