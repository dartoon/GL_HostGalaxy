#!/bin/bash

glee -M -i HE119

glee -h -H 20 HE119.mcmc
mv HE119.001 HE119_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE119_001 > HE119.001
glee -M -i HE119.001
./glee_chainout.sh
