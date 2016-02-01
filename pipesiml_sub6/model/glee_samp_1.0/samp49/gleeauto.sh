#!/bin/bash

glee -M -i HE49

glee -h -H 20 HE49.mcmc
mv HE49.001 HE49_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE49_001 > HE49.001
glee -M -i HE49.001
./glee_chainout.sh
