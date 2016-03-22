#!/bin/bash

glee -M -i HE45

glee -h -H 20 HE45.mcmc
mv HE45.001 HE45_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE45_001 > HE45.001
glee -M -i HE45.001
./glee_chainout.sh
