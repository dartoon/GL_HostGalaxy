#!/bin/bash

glee -M -i HE122

glee -h -H 20 HE122.mcmc
mv HE122.001 HE122_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE122_001 > HE122.001
glee -M -i HE122.001
./glee_chainout.sh
