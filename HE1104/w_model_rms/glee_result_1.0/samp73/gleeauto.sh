#!/bin/bash

glee -M -i HE73

glee -h -H 20 HE73.mcmc
mv HE73.001 HE73_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE73_001 > HE73.001
glee -M -i HE73.001
./glee_chainout.sh
