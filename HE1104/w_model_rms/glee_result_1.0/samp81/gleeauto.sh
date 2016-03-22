#!/bin/bash

glee -M -i HE81

glee -h -H 20 HE81.mcmc
mv HE81.001 HE81_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE81_001 > HE81.001
glee -M -i HE81.001
./glee_chainout.sh
