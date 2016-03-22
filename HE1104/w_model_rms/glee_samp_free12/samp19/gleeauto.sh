#!/bin/bash

glee -M -i HE19

glee -h -H 20 HE19.mcmc
mv HE19.001 HE19_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE19_001 > HE19.001
glee -M -i HE19.001
./glee_chainout.sh
