#!/bin/bash

glee -M -i HE31

glee -h -H 20 HE31.mcmc
mv HE31.001 HE31_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE31_001 > HE31.001
glee -M -i HE31.001
./glee_chainout.sh
