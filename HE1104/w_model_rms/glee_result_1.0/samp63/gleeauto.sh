#!/bin/bash

glee -M -i HE63

glee -h -H 20 HE63.mcmc
mv HE63.001 HE63_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE63_001 > HE63.001
glee -M -i HE63.001
./glee_chainout.sh
